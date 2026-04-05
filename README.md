# Contact Project – Salesforce Apex Integration

## 📌 Project Overview

This project implements a Salesforce Apex solution that enriches Contact records with country data based on the contact's first name.
It integrates with an external API to automatically determine the most likely country of origin.

---

## 🚀 Features

* Apex Trigger on Contact (after insert)
* Separation of logic using a Handler Class
* HTTP Callout to external API
* JSON response parsing
* Automatic update of Contact country field
* Error handling for missing data and API failures
* Bulk-safe processing for multiple records

---

## 🔧 Setup Instructions

### 1. Salesforce Developer Org

* Create a Salesforce Developer account
* Log in and configure your environment

### 2. VS Code Setup

* Install Visual Studio Code
* Install Salesforce Extensions Pack
* Authorize your org using:

  ```
  SFDX: Authorize an Org
  ```

### 3. Clone Repository

```
git clone <your-repo-url>
cd contact-project
```

---

## ⚙️ Deployment

Deploy metadata using VS Code:

```
SFDX: Deploy Source to Org
```

Or via CLI:

```
sfdx force:source:deploy -p force-app
```

---

## 🧠 Technical Details

### Apex Components

* **Trigger**: Executes on Contact creation
* **Handler Class**: Contains business logic
* **Callout Class**: Handles API request

### API Integration

* Endpoint:

  ```
  https://api.nationalize.io/?name=<FirstName>
  ```

### Functionality

* Sends request using Contact FirstName
* Parses JSON response
* Extracts most probable country
* Updates Contact country field

### Error Handling

* Missing FirstName
* Empty API response
* HTTP callout failures

### Bulk Safety

* Processes multiple Contacts in one transaction
* Avoids SOQL/DML inside loops

---

## 🧪 Testing

### Test Coverage Includes:

* Successful API response
* Empty response handling
* API error simulation

### Mocking

* Uses `HttpCalloutMock` to simulate API responses

Run tests:

```
sfdx force:apex:test:run
```

---

## 🌐 External API

* https://api.nationalize.io

---

## 📦 Deliverables

* Apex Trigger
* Handler and Callout classes
* Test class with mocks
* Git repository with full implementation

---

## 👤 Author

* Cholponai Baktiiar kyzy

---

## 📄 Notes

This project was completed as part of a Salesforce development assignment focused on Apex, API integration, and DevOps practices.

