# MedCura - Emergency Medicine & Rural Health Access Platform

**"Never run out of life-saving medicine again."**

## Problem Statement

Government hospitals in remote areas often run out of critical medicine or equipment, and patients travel hours only to hear "stock finished."

## Solution

- **Real-time inventory monitoring** system for rural hospitals
- **Citizens can search** nearby pharmacies/hospitals for availability of medicine
- **Automated stock redistribution** system across hospitals
- **Predictive alerts** to prevent shortages

## Architecture

**Microservices Architecture** with the following services:

### Backend Services (Ballerina)

- **Hospital Service** (Port 9090) - Hospital registration, authentication, profile management
- **Inventory Service** (Port 9091) - Real-time inventory tracking and management
- **Search Service** (Port 9092) - Medicine/hospital search functionality
- **Notification Service** (Port 9093) - Alerts and notifications system
- **Analytics Service** (Port 9094) - Predictive analytics and reporting

### Frontend (Next.js)

- **Public Portal** - Medicine search for citizens (no registration required)
- **Hospital Dashboard** - Inventory management for registered hospitals
- **Admin Panel** - System monitoring and analytics

## Tech Stack

- **Frontend**: Next.js 14, TypeScript, Tailwind CSS
- **Backend**: Ballerina (Microservices)
- **Database**: MySQL (for structured data), Redis (for caching)
- **Authentication**: JWT tokens for hospitals

## Getting Started

### Backend Services

```bash
# Start Hospital Service
cd backend/hospital-service && bal run

# Start Inventory Service
cd backend/inventory-service && bal run

# Start Search Service
cd backend/search-service && bal run

# Start Notification Service
cd backend/notification-service && bal run
```

### Frontend

```bash
cd frontend && npm run dev
```

## API Endpoints

### Public Endpoints (No Auth Required)

- `GET /search/medicine/{name}` - Search medicine availability
- `GET /search/hospital/{location}` - Find nearby hospitals
- `GET /inventory/public/{medicineId}` - Public inventory check

### Hospital Endpoints (Auth Required)

- `POST /hospital/register` - Hospital registration
- `POST /hospital/login` - Hospital login
- `GET /hospital/dashboard` - Hospital dashboard data
- `POST /inventory/update` - Update medicine stock
- `GET /notifications/alerts` - Get stock alerts
