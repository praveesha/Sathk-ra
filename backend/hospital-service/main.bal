import ballerina/http;

service /hospital on new http:Listener(9090) {

    // Hospital Registration
    resource function post register(http:Request req) returns json|error {
        json payload = check req.getJsonPayload();

        // TODO: Validate hospital data and store in database
        // Fields: name, address, contact, license_number, admin_email, password

        json response = {
            "status": "success",
            "message": "Hospital registered successfully",
            "hospital_id": "HOS001",
            "registration_date": "2025-08-20"
        };

        return response;
    }

    // Hospital Login
    resource function post login(http:Request req) returns json|error {
        json payload = check req.getJsonPayload();

        // TODO: Validate credentials and generate JWT token

        json response = {
            "status": "success",
            "message": "Login successful",
            "token": "jwt_token_here",
            "hospital_id": "HOS001",
            "expires_in": 3600
        };

        return response;
    }

    // Get Hospital Profile (Authenticated)
    resource function get profile/[string hospitalId](http:Request req) returns json|error {
        // TODO: Validate JWT token from headers
        // TODO: Fetch hospital details from database

        json response = {
            "hospital_id": hospitalId,
            "name": "Colombo General Hospital",
            "address": "Colombo 08, Sri Lanka",
            "contact": "+94112691111",
            "license_number": "LIC001",
            "status": "active",
            "registered_date": "2025-01-15"
        };

        return response;
    }

    // Update Hospital Profile (Authenticated)
    resource function put profile/[string hospitalId](http:Request req) returns json|error {
        // TODO: Validate JWT token
        // TODO: Update hospital details in database

        json response = {
            "status": "success",
            "message": "Hospital profile updated successfully"
        };

        return response;
    }

    // Get Dashboard Data (Authenticated)
    resource function get dashboard/[string hospitalId](http:Request req) returns json|error {
        // TODO: Validate JWT token
        // TODO: Aggregate dashboard data from multiple services

        json response = {
            "hospital_id": hospitalId,
            "total_medicines": 245,
            "low_stock_alerts": 12,
            "out_of_stock": 3,
            "recent_updates": [
                {"medicine": "Paracetamol", "action": "stock_updated", "timestamp": "2025-08-20T10:30:00Z"},
                {"medicine": "Amoxicillin", "action": "low_stock_alert", "timestamp": "2025-08-20T09:15:00Z"}
            ]
        };

        return response;
    }
}
