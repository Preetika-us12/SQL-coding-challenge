
CREATE DATABASE IF NOT EXISTS PetPals;
USE PetPals;

CREATE TABLE IF NOT EXISTS Pets (
    PetID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    Age INT NOT NULL,
    Breed VARCHAR(50),
    Type VARCHAR(50),
    AvailableForAdoption BIT NOT NULL
);


CREATE TABLE IF NOT EXISTS Shelters (
    ShelterID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Location VARCHAR(255) NOT NULL
);


CREATE TABLE IF NOT EXISTS Donations (
    DonationID INT PRIMARY KEY AUTO_INCREMENT,
    DonorName VARCHAR(100),
    DonationType VARCHAR(50),
    DonationAmount DECIMAL(10, 2),
    DonationItem VARCHAR(100),
    DonationDate DATETIME
);


CREATE TABLE IF NOT EXISTS AdoptionEvents (
    EventID INT PRIMARY KEY AUTO_INCREMENT,
    EventName VARCHAR(100),
    EventDate DATETIME,
    Location VARCHAR(255)
);


CREATE TABLE IF NOT EXISTS Participants (
    ParticipantID INT PRIMARY KEY AUTO_INCREMENT,
    ParticipantName VARCHAR(100),
    ParticipantType VARCHAR(50),
    EventID INT,
    FOREIGN KEY (EventID) REFERENCES AdoptionEvents(EventID)
);


-- 1. Retrieve available pets for adoption
SELECT Name, Age, Breed, Type
FROM Pets
WHERE AvailableForAdoption = 1;

-- 2. Retrieve participant names and types for a specific event
SELECT ParticipantName, ParticipantType
FROM Participants
WHERE EventID = ?;

-- 3. Update shelter information
DELIMITER $$
CREATE PROCEDURE UpdateShelterInfo(
    IN ShelterIDParam INT,
    IN NewName VARCHAR(100),
    IN NewLocation VARCHAR(255)
)
BEGIN
    UPDATE Shelters
    SET Name = NewName, Location = NewLocation
    WHERE ShelterID = ShelterIDParam;
END $$
DELIMITER ;

-- 4. Total donation amount per shelter
SELECT Shelters.Name, COALESCE(SUM(Donations.DonationAmount), 0) AS TotalDonation
FROM Shelters
LEFT JOIN Donations ON Shelters.ShelterID = Donations.DonationID
GROUP BY Shelters.Name;

-- 5. Retrieve pets without owners
SELECT Name, Age, Breed, Type
FROM Pets
WHERE OwnerID IS NULL;

-- 6. Total donation amount by month and year
SELECT DATE_FORMAT(DonationDate, '%Y-%M') AS MonthYear, COALESCE(SUM(DonationAmount), 0) AS TotalDonation
FROM Donations
GROUP BY MonthYear;

-- 7. Distinct breeds of pets aged 1-3 years or older than 5 years
SELECT DISTINCT Breed
FROM Pets
WHERE Age BETWEEN 1 AND 3 OR Age > 5;

-- 8. Pets and their respective shelters available for adoption
SELECT Pets.Name, Shelters.Name AS ShelterName
FROM Pets
JOIN Shelters ON Pets.PetID = Shelters.ShelterID
WHERE Pets.AvailableForAdoption = 1;

-- 9. Total number of participants by city
SELECT COUNT(ParticipantID) AS TotalParticipants
FROM Participants
JOIN AdoptionEvents ON Participants.EventID = AdoptionEvents.EventID
WHERE Location = 'Chennai';

-- 10. Unique breeds for pets aged between 1 and 5 years
SELECT DISTINCT Breed
FROM Pets
WHERE Age BETWEEN 1 AND 5;

-- 11. Pets not adopted
SELECT Name, Age, Breed, Type
FROM Pets
WHERE AvailableForAdoption = 1;

-- 12. Adopted pets with adopter's name
SELECT Pets.Name AS PetName, Participants.ParticipantName AS AdopterName
FROM Pets
JOIN Participants ON Pets.PetID = Participants.ParticipantID
WHERE Participants.ParticipantType = 'Adopter';

-- 13. Shelters with the count of available pets for adoption
SELECT Shelters.Name, COUNT(Pets.PetID) AS AvailablePets
FROM Shelters
LEFT JOIN Pets ON Shelters.ShelterID = Pets.PetID AND Pets.AvailableForAdoption = 1
GROUP BY Shelters.Name;

-- 14. Pairs of pets from the same shelter with the same breed
SELECT P1.Name AS Pet1, P2.Name AS Pet2, P1.Breed, Shelters.Name AS ShelterName
FROM Pets P1
JOIN Pets P2 ON P1.ShelterID = P2.ShelterID AND P1.PetID < P2.PetID AND P1.Breed = P2.Breed
JOIN Shelters ON P1.ShelterID = Shelters.ShelterID;

-- 15. All combinations of shelters and adoption events
SELECT Shelters.Name AS ShelterName, AdoptionEvents.EventName
FROM Shelters
CROSS JOIN AdoptionEvents;

-- 16. Shelter with the highest number of adopted pets
SELECT Shelters.Name, COUNT(Pets.PetID) AS AdoptedPets
FROM Shelters
JOIN Pets ON Shelters.ShelterID = Pets.PetID
WHERE Pets.AvailableForAdoption = 0
GROUP BY Shelters.Name
ORDER BY AdoptedPets DESC
LIMIT 1;