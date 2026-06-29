# Asset Management System

A complete Back-end application built with Spring Boot for managing company assets, tracking inventory, and assigning them to employees.

## Features

- **Asset Management:** Full CRUD operations to add, view, update, and delete company assets.
- **Assignment Tracking:** Link assets to employees with assignment and return dates.
- **Database Backup:** Complete structure with automated Stored Procedures.
- **RESTful APIs:** Clean JSON-based endpoints for Front-end integration.

## Technologies Used

- **Java 17**
- **Spring Boot**
- **Spring Data JPA**
- **MySQL Database**
- **Maven**

## Project Structure

src/main/java/com/assets/management/
├── controller  <-- AssetController.java (Handles API Endpoints)
├── model       <-- Asset.java (Database Entity for Assets)
└── repository  <-- AssetRepository.java (Handles Database Operations)


## Database

The project includes the complete MySQL script ready for deployment:
asset_management_db.sql

It contains:
- Schema creation (`asset_management`)
- Table structures (`assets`, `asset_assignments`)
- Foreign key relationships
- Stored Procedures

## Installation & Setup

### 1. Download the Project
Download the repository files or download the ZIP folder and extract it.

### 2. Setup the Database
1. Open **MySQL Workbench**.
2. Open and run the `asset_management_db.sql` file to automatically build the database schema and procedures.

### 3. Configure Database Credentials
Open `src/main/resources/application.properties` and update your MySQL username and password:
properties
spring.datasource.url=jdbc:mysql://localhost:3306/asset_management
spring.datasource.username=YOUR_MYSQL_USERNAME
spring.datasource.password=YOUR_MYSQL_PASSWORD

4. Run the Application
Open the project folder inside VS Code and run the main application file:

ManagementApplication.java

API Endpoints (Assets)MethodEndpointDescriptionGET/api/assetsGet all company assetsGET/api/assets/{id}Get a specific asset by IDPOST/api/assetsAdd/Create a new assetPUT/api/assets/{id}Update existing asset detailsDELETE/api/assets/{id}Delete an asset from the system
