import ballerina/http;

service /notifications on new http:Listener(9093) {

    // Get Alerts for Hospital (Authenticated)
    resource function get alerts/[string hospitalId](http:Request req) returns json|error {
        // TODO: Validate JWT token
        // TODO: Fetch alerts from database

        json response = {
            "hospital_id": hospitalId,
            "active_alerts": [
                {
                    "alert_id": "ALT001",
                    "type": "critical_shortage",
                    "medicine_name": "Insulin",
                    "current_stock": 2,
                    "minimum_required": 20,
                    "severity": "critical",
                    "created_at": "2025-08-20T08:00:00Z",
                    "message": "Critical shortage: Only 2 units of Insulin remaining"
                },
                {
                    "alert_id": "ALT002",
                    "type": "low_stock",
                    "medicine_name": "Amoxicillin",
                    "current_stock": 15,
                    "minimum_required": 30,
                    "severity": "medium",
                    "created_at": "2025-08-20T09:30:00Z",
                    "message": "Low stock alert: Amoxicillin below minimum threshold"
                }
            ],
            "alert_summary": {
                "critical": 1,
                "high": 2,
                "medium": 4,
                "low": 5
            }
        };

        return response;
    }

    // Send Stock Alert (Internal Service Call)
    resource function post stockAlert(http:Request req) returns json|error {
        json payload = check req.getJsonPayload();
        // TODO: Process stock alert
        // TODO: Send notifications via SMS/Email
        // TODO: Update alert database

        json response = {
            "status": "success",
            "message": "Stock alert processed and notifications sent",
            "alert_id": "ALT003",
            "notifications_sent": 3
        };

        return response;
    }

    // Get Predictive Analytics Alerts (Authenticated)
    resource function get predictive/[string hospitalId]() returns json|error {
        // TODO: Validate JWT token
        // TODO: Run predictive analytics based on usage patterns

        json response = {
            "hospital_id": hospitalId,
            "predictions": [
                {
                    "medicine_name": "Paracetamol",
                    "current_stock": 150,
                    "predicted_depletion": "2025-09-15",
                    "days_remaining": 26,
                    "recommended_order": 200,
                    "confidence": 0.87
                },
                {
                    "medicine_name": "Bandages",
                    "current_stock": 45,
                    "predicted_depletion": "2025-08-28",
                    "days_remaining": 8,
                    "recommended_order": 100,
                    "confidence": 0.92
                }
            ],
            "analysis_date": "2025-08-20T12:00:00Z"
        };

        return response;
    }

    // Mark Alert as Acknowledged (Authenticated)
    resource function post acknowledge/[string alertId](http:Request req) returns json|error {
        // TODO: Validate JWT token
        // TODO: Mark alert as acknowledged in database

        json response = {
            "status": "success",
            "message": "Alert acknowledged",
            "alert_id": alertId,
            "acknowledged_at": "2025-08-20T13:00:00Z"
        };

        return response;
    }

    // Get Redistribution Suggestions (Authenticated)
    resource function get redistribute/[string hospitalId]() returns json|error {
        // TODO: Validate JWT token
        // TODO: Find nearby hospitals with excess stock

        json response = {
            "hospital_id": hospitalId,
            "redistribution_opportunities": [
                {
                    "medicine_name": "Insulin",
                    "your_shortage": 18,
                    "available_from": [
                        {
                            "hospital_id": "HOS005",
                            "hospital_name": "Kalubowila Hospital",
                            "excess_stock": 45,
                            "distance": "12km",
                            "contact": "+94112763700",
                            "can_provide": 20
                        }
                    ],
                    "suggested_action": "Contact Kalubowila Hospital for emergency stock transfer"
                }
            ],
            "analysis_timestamp": "2025-08-20T13:15:00Z"
        };

        return response;
    }

    // System Health Alerts (Admin only)
    resource function get system() returns json|error {
        // TODO: System-wide alerts and monitoring

        json response = {
            "system_alerts": [
                {
                    "type": "region_shortage",
                    "region": "Western Province",
                    "medicine": "Insulin",
                    "affected_hospitals": 5,
                    "severity": "high",
                    "created_at": "2025-08-20T11:00:00Z"
                }
            ],
            "system_health": {
                "total_hospitals": 45,
                "hospitals_online": 42,
                "critical_shortages": 8,
                "last_check": "2025-08-20T13:00:00Z"
            }
        };

        return response;
    }
}
