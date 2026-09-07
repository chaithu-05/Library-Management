# 📚 Library Management System

An enterprise-ready transactional application built using **SAP ABAP Cloud**, the **SAP RESTful Application Programming Model (RAP)**, and **SAP Fiori Elements** to manage, catalog, track, and circulate library assets efficiently in the SAP BTP ABAP Environment.



## Features

- **Full Lifecycle RAP Architecture:** Managed end-to-end CRUD operations powered by system-generated UUIDs and integrated draft enablement to preserve uncommitted edits.
- **Custom Business Logic & Automation:** Native ABAP action implementations (`checkOut`, `returnBook`) that dynamically compute 14-day return due dates from the system date.
- **Dynamic Feature Control:** Contextual instance-based button enablement (`get_instance_features`) that selectively enables or disables actions depending on book availability.
- **Data Integrity Validations:** Backend save-sequence validation (`validateBook`) enforcing mandatory fields and blocking checkouts with past due dates.
- **Responsive UI Customization:** Optimized CDS `@UI` line-item annotations configured for full container width with balanced column distribution.



## Application Walkthrough

### 1. Book Catalog & List Report View
The main worklist displays real-time inventory, category classifications, current borrowing states, and dynamic due dates across an edge-to-edge responsive layout.

<img width="1917" height="912" alt="Screenshot 2026-09-07 234200" src="https://github.com/user-attachments/assets/8840d012-aff8-47f4-86a6-1b2664e0985d" />



### 2. Multi-Select & Contextual Feature Control
Users can select multiple titles across the catalog. The application dynamically assesses each record's state, enabling valid batch actions like **Check Out** or **Return Book** while greying out invalid operations.

<img width="1917" height="911" alt="Screenshot 2026-09-07 234229" src="https://github.com/user-attachments/assets/4c7c8701-be55-462e-add4-ede6ae1886f0" />



### 3. Detailed Book Information
Drill down into any individual title to access the dedicated SAP Fiori Object Page layout detailing partitioned book metadata, circulation status, and transactional controls.

<img width="1917" height="547" alt="Screenshot 2026-09-07 234302" src="https://github.com/user-attachments/assets/bdbd2cec-c8ed-4119-a27a-e5944286a339" />



## Tech Stack & Architecture

- **Language:** SAP ABAP Cloud (Clean ABAP / Object-Oriented)
- **Development Model:** SAP RESTful Application Programming Model (RAP)
- **Data Modeling:** ABAP Core Data Services (CDS View Entities & Projection Views)
- **Persistence:** ABAP Dictionary (DDIC) Tables (`ZLIB_BOOKS`, `ZLIB_BOOKS_D`)
- **Protocol:** OData V4 (Service Definition & Binding)
- **UI Framework:** SAP Fiori Elements (List Report & Object Page)
- **Environment:** SAP BTP ABAP Environment
- **Version Control:** abapGit



## Repository Artifacts

- **`ZLIB_BOOKS` / `ZLIB_BOOKS_D`**: Transparent database table and draft table managing active and in-flight records.
- **`ZR_LIB_BOOKS`**: Core root CDS entity defining data types, keys, and base structure.
- **`ZC_LIB_BOOKS`**: Consumption CDS projection view carrying `@UI` annotations for Fiori Elements rendering.
- **`ZR_LIB_BOOKS` (BDEF)**: RAP behavior definition managing transactions, draft handling, actions, and validation hooks.
- **`ZBP_R_LIB_BOOKS`**: ABAP behavior pool class implementing operational checkout/return actions, feature control, and validation logic.
- **`ZUI_LIB_BOOKS` & `ZUI_LIB_BOOKS_O4`**: Service definition and OData V4 UI service binding exposing the data model.
- **`ZCL_LIB_FILL_DATA`**: ABAP class utility used to seed initial mock library books into the persistence layer.
