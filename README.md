# Asset Management System

A robust Back-end application built with Spring Boot for managing company assets, tracking inventory, and assigning them to employees. 

---

## Project Architecture (Layers)

The system follows a standard layered architecture to separate concerns and ensure maintainability:

1. Presentation Layer (controller): Exposes RESTful API endpoints and manages HTTP requests/responses (JSON).
2. Business Logic Layer (service): (Planned for V2) To handle core validation and business rules separately from controllers.
3. Data Access Layer (repository): Extends JpaRepository to perform CRUD operations on the database.
4. Data Layer (model/entity): Represents database tables as Java objects mapped via Hibernate.

5. src/main/java/com/assets/management/
├── config/            # System & Security configurations (Future)
├── controller/        # AssetController.java (API Endpoints)
├── dto/               # Data Transfer Objects for secure requests (Future)
├── exception/         # Global Exception Handlers (Future)
├── model/             # Asset.java (Database Entity)
├── repository/        # AssetRepository.java (Database Access)
└── service/           # Business Logic Layer (Future Implementation)

---

## Technologies & Features

- Java 17 & Spring Boot 3.x
- Spring Data JPA & Hibernate
- MySQL Database 8.0
- Maven for Dependency Management

### Key Missing Frameworks (Planned for V2):
- Authentication & Authorization: Spring Security & JWT (JSON Web Tokens) to manage Roles (Admin, Manager, Employee).
- Data Validation: Bean Validation (@Valid, @NotNull, @Size) will be integrated to secure payload entries.
- API Documentation: OpenAPI / Swagger integration for interactive API testing.
- Logging & Monitoring: SLF4J and Logback to track operational tasks and debug errors.
- Testing: JUnit 5 and Mockito for Unit and Integration testing to maximize coverage.
- Containerization: Docker & Docker Compose setup for easy environmental replication.
- CI/CD Pipeline: GitHub Actions for automated building and testing.

---

## Business Rules & System Constraints

To maintain data integrity, the system adheres to the following core operational rules:
- An asset cannot be assigned to multiple employees simultaneously.
- An asset cannot be marked as "Returned" twice without a new assignment lifecycle.
- Prevent Hard Deletes: Hard deleting an active asset is restricted if it is currently assigned to an employee. 
- Soft Delete Implementation: Planned feature where assets will use an is_deleted flag instead of permanent SQL row deletion to preserve historical audit logs.

---

## Database Schema & Architecture

The project connects to a relational schema named asset_management. It contains tables for assets and an associative bridge table asset_assignments to resolve the Many-to-Many relationship between Assets and Employees.

### Audit Fields (Trackers)
To comply with production standards, the database tables include/plan to include:
- created_at / updated_at: Automatically populated timestamps.
- created_by / updated_by: Identity logs tracking the user who made modifications.

### Stored Procedures Documentation
The database script includes optimized Stored Procedures to offload heavy structural database operations:
1. GetActiveAssignments: Retrieves all assets currently held by staff.
2. ArchiveOldAssignments: Transfers completed records to history logs.

---

## Installation & Setup

### 1. Environmental Variables Setup
Instead of modifying the core properties directly, copy the environment template:
Create a .env or check .env.example to supply system secrets securely.

### 2. Setup the Database & Backups
1. Open MySQL Workbench.
2. Run the asset_management_db.sql script to build the schema, structural indexes, and stored procedures.
3. Backup Strategy: Regular structural backups are triggered using mysqldump to generate safe schema rollbacks.

### 3. Configure Database Credentials
Open src/main/resources/application.properties:
properties
spring.datasource.url=jdbc:mysql://localhost:3306/asset_management
spring.datasource.username=${DB_USERNAME:root}
spring.datasource.password=${DB_PASSWORD:your_password}

4. Run the Application
Bash
mvn spring-boot:run

API Endpoints (v1 Versioning)All endpoints follow URL versioning (/api/v1/...).MethodEndpointDescriptionGET/api/v1/assetsGet all assets (Pagination & Sorting pending)GET/api/v1/assets/{id}Get a specific asset by IDPOST/api/v1/assetsAdd a new assetPUT/api/v1/assets/{id}Update existing asset detailsDELETE/api/v1/assets/{id}Remove/Soft delete an asset

Sample JSON Payload (POST /api/v1/assets)
Request Body:
{
  "assetCode": "AST-1022",
  "assetName": "MacBook Pro M3",
  "purchaseCost": 2499.00,
  "serialNumber": "SN-998231AA",
  "statusId": 1
}

Response Body (201 Created):
{
  "assetId": 12,
  "assetCode": "AST-1022",
  "assetName": "MacBook Pro M3",
  "purchaseCost": 2499.00,
  "serialNumber": "SN-998231AA",
  "statusId": 1,
  "createdAt": "2026-07-01T12:00:00"
}

Global Exception Handling & Performance
Database Errors: Custom validation layers intercept SQL integration issues (e.g., trying to delete an assigned asset) to return user-friendly alert messages instead of raw SQL crashes.

Performance Optimization: Fields like asset_code and serial_number utilize Database Indexes to prevent full-table scans. Future versions will integrate Server Pagination and Sorting to avoid system throttling under massive loads.

Roadmap & Future Improvements
Implement JWT Security Layer and Role Management.

Refactor codebase to include full Service and DTO sub-layers.

Add complete Global Exception Handling and logging infrastructure.

Introduce full Pagination, advanced Sorting, and dynamic filtering.

License
Distributed under the MIT License. See LICENSE for more information.
