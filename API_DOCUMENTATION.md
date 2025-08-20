# MedCura API Documentation

## Overview

MedCura provides a comprehensive API for emergency medicine access across rural hospitals. The platform consists of multiple microservices handling different aspects of the system.

## Services Architecture

### 1. Hospital Service (Port 9090)

Handles hospital registration, authentication, and profile management.

### 2. Inventory Service (Port 9091)

Manages real-time medicine inventory across all hospitals.

### 3. Search Service (Port 9092)

Provides search functionality for medicines and hospitals.

### 4. Notification Service (Port 9093)

Manages alerts, notifications, and predictive analytics.

---

## API Endpoints

### 🏥 Hospital Service (http://localhost:9090)

#### POST /hospital/register

Register a new hospital in the system.

```json
{
  "name": "Colombo General Hospital",
  "address": "Colombo 08, Sri Lanka",
  "contact": "+94112691111",
  "license_number": "LIC001",
  "admin_email": "admin@hospital.gov.lk",
  "password": "securepassword"
}
```

#### POST /hospital/login

Authenticate hospital administrator.

```json
{
  "email": "admin@hospital.gov.lk",
  "password": "securepassword"
}
```

#### GET /hospital/profile/{hospitalId}

Get hospital profile information. Requires authentication.

#### PUT /hospital/profile/{hospitalId}

Update hospital profile. Requires authentication.

#### GET /hospital/dashboard/{hospitalId}

Get hospital dashboard data with inventory summary. Requires authentication.

---

### 📦 Inventory Service (http://localhost:9091)

#### GET /inventory/publicSearch/{medicineId}

**Public endpoint** - Search medicine availability across hospitals.

```json
Response:
{
  "medicine_id": "MED001",
  "medicine_name": "Paracetamol",
  "total_stock": 450,
  "available_hospitals": [
    {
      "hospital_id": "HOS001",
      "hospital_name": "Colombo General Hospital",
      "stock": 150,
      "distance": "2.5km",
      "contact": "+94112691111"
    }
  ]
}
```

#### POST /inventory/update

Update medicine stock. Hospital authentication required.

```json
{
  "medicine_id": "MED001",
  "new_stock": 85,
  "hospital_id": "HOS001"
}
```

#### GET /inventory/hospital/{hospitalId}

Get complete inventory for a hospital. Authentication required.

#### POST /inventory/hospital/{hospitalId}/add

Add new medicine to hospital inventory. Authentication required.

#### GET /inventory/alerts/{hospitalId}

Get stock alerts for hospital. Authentication required.

---

### 🔍 Search Service (http://localhost:9092)

#### GET /search/medicine/{medicineName}

**Public endpoint** - Search medicines by name or partial match.

```json
Response:
{
  "search_term": "paracetamol",
  "results": [
    {
      "medicine_id": "MED001",
      "medicine_name": "Paracetamol 500mg",
      "category": "Analgesic",
      "total_available": 450,
      "hospitals_available": 8,
      "nearest_hospital": {
        "hospital_id": "HOS001",
        "name": "Colombo General Hospital",
        "distance": "2.5km",
        "stock": 150,
        "contact": "+94112691111"
      }
    }
  ]
}
```

#### GET /search/hospital/{location}

**Public endpoint** - Find hospitals by location/district.

#### GET /search/advanced

**Public endpoint** - Advanced search with filters.
Query parameters: medicine_name, category, location, max_distance, min_stock

#### GET /search/popular

**Public endpoint** - Get frequently searched medicines.

---

### 🔔 Notification Service (http://localhost:9093)

#### GET /notifications/alerts/{hospitalId}

Get active alerts for hospital. Authentication required.

#### POST /notifications/stockAlert

Internal service call to process stock alerts.

#### GET /notifications/predictive/{hospitalId}

Get predictive analytics alerts. Authentication required.

```json
Response:
{
  "hospital_id": "HOS001",
  "predictions": [
    {
      "medicine_name": "Paracetamol",
      "current_stock": 150,
      "predicted_depletion": "2025-09-15",
      "days_remaining": 26,
      "recommended_order": 200,
      "confidence": 0.87
    }
  ]
}
```

#### POST /notifications/acknowledge/{alertId}

Mark alert as acknowledged. Authentication required.

#### GET /notifications/redistribute/{hospitalId}

Get redistribution suggestions. Authentication required.

#### GET /notifications/system

System-wide alerts and monitoring. Admin access required.

---

## Authentication

### JWT Tokens

Hospital endpoints require JWT tokens in the Authorization header:

```
Authorization: Bearer <jwt_token>
```

### Public Endpoints

The following endpoints are public and require no authentication:

- All Search Service endpoints
- `GET /inventory/publicSearch/{medicineId}`

---

## Error Responses

All services return consistent error responses:

```json
{
  "error": "Error message",
  "code": "ERROR_CODE",
  "timestamp": "2025-08-20T12:00:00Z"
}
```

### Common HTTP Status Codes

- `200` - Success
- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `500` - Internal Server Error

---

## Rate Limiting

### Public Endpoints

- 100 requests per minute per IP
- 1000 requests per hour per IP

### Authenticated Endpoints

- 200 requests per minute per hospital
- 5000 requests per hour per hospital

---

## Data Models

### Medicine

```json
{
  "medicine_id": "string",
  "name": "string",
  "category": "string",
  "description": "string",
  "unit": "string"
}
```

### Hospital

```json
{
  "hospital_id": "string",
  "name": "string",
  "address": "string",
  "district": "string",
  "contact": "string",
  "coordinates": {
    "latitude": "number",
    "longitude": "number"
  }
}
```

### Inventory Item

```json
{
  "medicine_id": "string",
  "hospital_id": "string",
  "current_stock": "number",
  "minimum_threshold": "number",
  "expiry_date": "string",
  "last_updated": "string"
}
```

---

## Getting Started

1. **Start all services:**

   ```bash
   ./start-medcura-macos.sh
   ```

2. **Or start individual services:**

   ```bash
   cd backend/hospital-service && bal run
   cd backend/inventory-service && bal run
   cd backend/search-service && bal run
   cd backend/notification-service && bal run
   cd frontend && npm run dev
   ```

3. **Access the application:**
   - Public Search: http://localhost:3000
   - Hospital Login: http://localhost:3000/hospital/login

---

## Support

For technical support or questions about the API, please refer to the project documentation or contact the development team.
