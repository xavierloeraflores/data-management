# D597 Task 2 Writeup

Xavier Loera Flores

ID:011037676

xloeraf@wgu.edu

D596 Data Management

# Design Document

---

## Business Scenario

HealthFit Innovations is an healthcare technology company on a mission to build innovative solutions that improve patient care and healthcare management. The company is developing a new healthcare data platform called "HealthTrack" for collecting, analyzing, and presenting key insights into patient data that needs to be stored in a database. Since the platform is designed to integrate data from various sources, the current relational database solution is struggling to cope and scale with the influx of complex and dynamic data coming into the platform. The company is seeking a non-relational database solution that can handle their data needs, while ensuring that the solution is scalable, flexible, and efficient.

### Business Problem

HealthFit Innovations is facing challenges with their current relational database management system (RDBMS) since it is not able to scale effectively to handle high volume and dynamically changing data in real time. This leads to performance bottlenecks and integration challenges. The company needs a solution that can address these problems while providing scalability to accommodate the growing user base, and ensuring flexibility in data management.

### NoSQL Justification & Database Type

A NoSQL database solution is justified for HealthTrack due to the following reasons:

-   **Scalability**: NoSQL databases are designed to scale horizontally by allowing more servers to handle increased data loads.
-   **Flexibility**: NoSQL databases are flexible since they can handle unstructured and semi-structured data which would allow HealthFit to store data from different data sources and devices.
-   **Performance**: NoSQL databases can provide faster read and write operations which may help for health analysis and real-time monitoring.
-   **Data Model**: A document-based or key-value data model can be utilized to store complex health data associated with a patient.

For HealthTrack, MongoDB would best suit to accommodate the diverse data types and structures. One of the benefits of using MongoDB include its ability to store JSON-like documents to easily represent the various health data attributes and relationships.

### \_\_Business Data Usage

There are two main types of data that HealthFit Innovations will be managing:

Patient Medical Records:

-   Patient ID
-   Name
-   Date of birth
-   Gender
-   Medical conditions
-   Medications
-   Allergies
-   Last appointment date

Medical Device Data:

-   Brand Name
-   Device Type
-   Model Name
-   Color
-   Selling Price
-   Original Price
-   Display
-   Rating
-   Strap Material
-   Average Battery Life
-   Reviews

---

## Scalability Concerns and Strategies

---

## Privacy and Security Measures

The following measures will be implemented to ensure HealthKit's and HIPAA's level of privacy and security are met in the proposed database design.

-   Access controls and role-based permissions will limit database access based on user roles to ensure only authorized personnel can view or modify personal medical data.
-   Sensitive data like patient information should be encrypted using secure encryption algorithms to protect incase of an unauthorized access.
-   Logging and auditing must be set up to track and detect malicious database activity and breaches.

---
