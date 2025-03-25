# PetPals - Happy Tails Adoption
## Overview  
PetPals is a structured database system designed to streamline the pet adoption process by managing **pets, shelters, donations, adoption events, and participants**. This project includes SQL scripts for database creation, structured queries, and stored procedures to facilitate efficient adoption management.  

---

## Database Schema  
PetPals consists of the following tables:

### 1) **Pets**  
Stores details about pets available for adoption.  
- **PetID** (Primary Key, INT) – Unique pet identifier  
- **Name** (VARCHAR) – Pet's name  
- **Age** (INT) – Pet's age  
- **Breed** (VARCHAR) – Pet's breed  
- **Type** (VARCHAR) – Type of pet (Dog, Cat, etc.)  
- **AvailableForAdoption** (BIT) – 0 (Not available), 1 (Available)  

### 2) **Shelters**  
Stores information about pet shelters.  
- **ShelterID** (Primary Key, INT) – Unique shelter identifier  
- **Name** (VARCHAR) – Shelter's name  
- **Location** (VARCHAR) – Address of the shelter  

### 3) **Donations**  
Manages monetary and item donations.  
- **DonationID** (Primary Key, INT) – Unique donation identifier  
- **DonorName** (VARCHAR) – Name of the donor  
- **DonationType** (VARCHAR) – Type of donation (Cash, Item)  
- **DonationAmount** (DECIMAL) – Donated amount (if cash)  
- **DonationItem** (VARCHAR) – Donated item (if applicable)  
- **DonationDate** (DATETIME) – Date and time of donation  

### 4) **AdoptionEvents**  
Stores details about pet adoption events.  
- **EventID** (Primary Key, INT) – Unique event identifier  
- **EventName** (VARCHAR) – Name of the event  
- **EventDate** (DATETIME) – Date and time of the event  
- **Location** (VARCHAR) – Event venue  

### 5) **Participants**  
Manages event participants.  
- **ParticipantID** (Primary Key, INT) – Unique participant identifier  
- **ParticipantName** (VARCHAR) – Name of participant (Shelter or Adopter)  
- **ParticipantType** (VARCHAR) – Type (Shelter or Adopter)  
- **EventID** (Foreign Key, INT) – References `EventID` from `AdoptionEvents`  

---

##  Implemented Tasks  
###  **Database Setup & Management**  
* **SQL script** for creating and initializing the PetPals database.  
* Tables and relationships defined with **primary keys & foreign keys**.  
* Handles potential **duplication errors** (if database/tables already exist).  

### **SQL Queries for Data Retrieval**  
* **Retrieve pets available for adoption** along with details.
* **List participants** for a given adoption event.
* **Retrieve shelters and their respective donations** (Total donation amount per shelter).
* **Find pets without owners** to identify those still up for adoption.
* **Calculate monthly donation statistics** (total donation per month & year).
* **Find distinct pet breeds** of animals aged **1-3 years or older than 5 years**.
* **Retrieve available pets along with their shelters**.
* **Count total participants in adoption events held in a specific city**.  
* **Find unique pet breeds aged between 1 and 5 years**.  
* **List all pets not yet adopted**.  
* **Retrieve a list of adopted pets with adopter names**.  
* **Count available pets per shelter** to track pet adoption trends.  
* **Find pets of the same breed in the same shelter**.  
* **Generate all possible combinations of shelters and adoption events**.
* **Determine the shelter with the highest number of adopted pets**.  

###  **Stored Procedures & Advanced Queries**  
* **Stored Procedure to update shelter details** (Change shelter name & location).  
* **Complex joins and aggregations** to extract insights.  
