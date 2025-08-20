import ballerina/http;

// Simple JWT validation function (placeholder)
function validateJWT(string authHeader) returns string|error {
    // TODO: Implement proper JWT validation
    // For now, extract hospital_id from a mock token
    if (authHeader.startsWith("Bearer ")) {
        return "HOS001"; // Mock hospital ID
    }
    return error("Invalid token");
}

service /inventory on new http:Listener(9091) {

    // Get Public Medicine Availability (No Auth Required)
    resource function get publicSearch/[string medicineId]() returns json|error {
        // TODO: Query database for medicine availability across all hospitals

        json response = {
            "medicine_id": medicineId,
            "medicine_name": "Paracetamol",
            "total_stock": 450,
            "available_hospitals": [
                {
                    "hospital_id": "HOS001",
                    "hospital_name": "Colombo General Hospital",
                    "stock": 150,
                    "distance": "2.5km",
                    "contact": "+94112691111"
                },
                {
                    "hospital_id": "HOS002",
                    "hospital_name": "National Hospital",
                    "stock": 200,
                    "distance": "4.1km",
                    "contact": "+94112691222"
                }
            ],
            "last_updated": "2025-08-20T11:30:00Z"
        };

        return response;
    }

    // Update Medicine Stock (Authenticated - Hospital Only)
    resource function post update(http:Request req) returns json|error {
        // Validate authentication
        string|http:HeaderNotFoundError authHeaderResult = req.getHeader("Authorization");
        string authHeader = authHeaderResult is string ? authHeaderResult : "";
        string hospitalId = check validateJWT(authHeader);

        json payload = check req.getJsonPayload();

        // Extract update data from payload (with proper error handling)
        json medicineIdJson = check payload.medicine_id;
        json newStockJson = check payload.new_stock;
        json requestHospitalIdJson = check payload.hospital_id;

        string medicineId = medicineIdJson.toString();
        int newStock = check int:fromString(newStockJson.toString());
        string requestHospitalId = requestHospitalIdJson.toString();

        // Ensure hospital can only update their own inventory
        if (hospitalId != requestHospitalId) {
            return error("Unauthorized: Cannot update inventory for other hospitals");
        }

        // TODO: Update stock in database
        // TODO: Check if stock is below threshold and trigger alerts

        boolean alertTriggered = newStock < 30; // Mock threshold check

        json response = {
            "status": "success",
            "message": "Stock updated successfully",
            "medicine_id": medicineId,
            "hospital_id": hospitalId,
            "previous_stock": 150, // TODO: Get from database
            "new_stock": newStock,
            "alert_triggered": alertTriggered,
            "updated_at": "2025-08-20T12:00:00Z"
        };

        return response;
    }

    // Get Hospital Inventory (Authenticated - Hospital Only)
    resource function get hospital/[string hospitalId](http:Request req) returns json|error {
        // Validate authentication
        string|http:HeaderNotFoundError authHeaderResult = req.getHeader("Authorization");
        string authHeader = authHeaderResult is string ? authHeaderResult : "";
        string authenticatedHospitalId = check validateJWT(authHeader);

        // Ensure hospital can only access their own inventory
        if (authenticatedHospitalId != hospitalId) {
            return error("Unauthorized: Cannot access inventory for other hospitals");
        }

        // TODO: Fetch hospital-specific inventory from database
        // For now, return mock data based on hospitalId

        json response = {
            "hospital_id": hospitalId,
            "medicines": [
                {
                    "medicine_id": "MED001",
                    "name": "Paracetamol",
                    "current_stock": 150,
                    "minimum_threshold": 50,
                    "status": "adequate",
                    "expiry_date": "2026-12-31",
                    "last_updated": "2025-08-20T10:30:00Z"
                },
                {
                    "medicine_id": "MED002",
                    "name": "Amoxicillin",
                    "current_stock": 25,
                    "minimum_threshold": 30,
                    "status": "low_stock",
                    "expiry_date": "2025-11-15",
                    "last_updated": "2025-08-20T09:15:00Z"
                },
                {
                    "medicine_id": "MED003",
                    "name": "Insulin",
                    "current_stock": 0,
                    "minimum_threshold": 20,
                    "status": "out_of_stock",
                    "expiry_date": "2025-12-31",
                    "last_updated": "2025-08-19T14:00:00Z"
                },
                {
                    "medicine_id": "MED004",
                    "name": "Aspirin",
                    "current_stock": 85,
                    "minimum_threshold": 40,
                    "status": "adequate",
                    "expiry_date": "2025-09-30",
                    "last_updated": "2025-08-20T11:00:00Z"
                }
            ],
            "summary": {
                "total_medicines": 4,
                "low_stock_count": 1,
                "out_of_stock_count": 1,
                "expiring_soon": 1
            }
        };

        return response;
    }

    // Add New Medicine to Hospital Inventory (Authenticated)
    resource function post hospital/[string hospitalId]/add(http:Request req) returns json|error {
        // Validate authentication
        string|http:HeaderNotFoundError authHeaderResult = req.getHeader("Authorization");
        string authHeader = authHeaderResult is string ? authHeaderResult : "";
        string authenticatedHospitalId = check validateJWT(authHeader);

        // Ensure hospital can only add to their own inventory
        if (authenticatedHospitalId != hospitalId) {
            return error("Unauthorized: Cannot add medicine to other hospital's inventory");
        }

        json payload = check req.getJsonPayload();

        // Extract medicine data from payload
        json medicineNameJson = check payload.medicine_name;
        json initialStockJson = check payload.initial_stock;
        json minimumThresholdJson = check payload.minimum_threshold;
        json expiryDateJson = check payload.expiry_date;

        string medicineName = medicineNameJson.toString();
        int initialStock = check int:fromString(initialStockJson.toString());

        // TODO: Validate medicine data and add to database

        json response = {
            "status": "success",
            "message": "Medicine added to inventory successfully",
            "medicine_id": "MED005", // Generated ID
            "medicine_name": medicineName,
            "initial_stock": initialStock,
            "hospital_id": hospitalId,
            "added_at": "2025-08-20T13:00:00Z"
        };

        return response;
    }

    // Get Stock Alerts for Hospital (Authenticated)
    resource function get alerts/[string hospitalId]() returns json|error {
        // TODO: Validate JWT token
        // TODO: Fetch alerts from database

        json response = {
            "hospital_id": hospitalId,
            "alerts": [
                {
                    "alert_id": "ALT001",
                    "type": "low_stock",
                    "medicine_name": "Insulin",
                    "current_stock": 5,
                    "threshold": 20,
                    "severity": "high",
                    "created_at": "2025-08-20T08:00:00Z"
                },
                {
                    "alert_id": "ALT002",
                    "type": "expiring_soon",
                    "medicine_name": "Antibiotics",
                    "expiry_date": "2025-09-15",
                    "stock": 50,
                    "severity": "medium",
                    "created_at": "2025-08-19T14:30:00Z"
                }
            ]
        };

        return response;
    }
}
