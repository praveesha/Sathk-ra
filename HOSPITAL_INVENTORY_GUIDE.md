# Hospital Inventory Management System

## 🏥 Hospital Worker Features Implemented

### 1. **Secure Authentication**

- Hospital workers must log in with valid credentials
- JWT token-based authentication for all inventory operations
- Session management with automatic logout on token expiry

### 2. **Inventory Dashboard**

- **Real-time inventory view** with current stock levels
- **Summary cards** showing:
  - Total medicines in inventory
  - Low stock alerts count
  - Out of stock items
  - Medicines expiring soon

### 3. **Stock Management**

- **Update Stock Levels**: Click "Update Stock" on any medicine to modify quantities
- **In-line editing**: Edit stock directly in the table with save/cancel options
- **Real-time updates**: Changes reflect immediately in the dashboard
- **Validation**: Prevents negative stock values

### 4. **Add New Medicines**

- **Add Medicine Modal**: Click "+ Add Medicine" button
- **Medicine details**: Name, initial stock, minimum threshold, expiry date
- **Form validation**: Required fields and proper data types
- **Instant updates**: New medicines appear immediately in inventory

### 5. **Visual Stock Status**

- **Color-coded status indicators**:
  - 🟢 Green: Adequate stock
  - 🟡 Yellow: Low stock (below threshold)
  - 🔴 Red: Out of stock
- **Expiry date tracking**: Shows medicines approaching expiry

### 6. **Security Features**

- **Hospital isolation**: Workers can only access their own hospital's inventory
- **Authorization checks**: All API calls require valid tokens
- **Data validation**: Proper input sanitization and error handling

## 📱 How Hospital Workers Use the System

### **Login Process**

1. Visit `/hospital/login`
2. Enter hospital email and password
3. System validates credentials and provides access token
4. Automatic redirect to dashboard

### **Managing Inventory**

1. **View Current Stock**: Dashboard shows all medicines with current levels
2. **Update Stock**:
   - Click "Update Stock" next to any medicine
   - Enter new stock amount
   - Click "Save" to confirm changes
3. **Add New Medicine**:
   - Click "+ Add Medicine" button
   - Fill in medicine details (name, stock, threshold, expiry)
   - Submit form to add to inventory

### **Monitoring Alerts**

- Dashboard highlights medicines requiring attention:
  - Low stock warnings (yellow indicators)
  - Out of stock alerts (red indicators)
  - Expiring medicines notifications

## 🔒 API Endpoints for Hospital Workers

### **Authentication Required Endpoints**

#### Update Medicine Stock

```
POST /inventory/update
Authorization: Bearer <jwt_token>
{
  "medicine_id": "MED001",
  "hospital_id": "HOS001",
  "new_stock": 150
}
```

#### Get Hospital Inventory

```
GET /inventory/hospital/{hospitalId}
Authorization: Bearer <jwt_token>
```

#### Add New Medicine

```
POST /inventory/hospital/{hospitalId}/add
Authorization: Bearer <jwt_token>
{
  "medicine_name": "Aspirin 500mg",
  "initial_stock": 100,
  "minimum_threshold": 20,
  "expiry_date": "2026-12-31"
}
```

## 🚀 Getting Started for Hospital Workers

1. **Hospital Registration**: Register your hospital at `/hospital/register`
2. **Login**: Access the system at `/hospital/login`
3. **Manage Inventory**: Use the dashboard at `/hospital/dashboard`

## 🛡️ Security & Access Control

- **JWT Authentication**: All inventory operations require valid authentication
- **Hospital Isolation**: Workers can only access their own hospital's data
- **Session Management**: Automatic logout on token expiry
- **Input Validation**: All user inputs are validated server-side
- **Error Handling**: Comprehensive error messages for troubleshooting

## 📊 Real-time Features

- **Live Stock Updates**: Changes reflect immediately across all views
- **Alert System**: Instant notifications for low stock/expiry issues
- **Status Indicators**: Real-time visual feedback on inventory health

The system ensures that hospital workers have secure, intuitive access to manage their medicine inventory while maintaining data integrity and preventing unauthorized access to other hospitals' data.
