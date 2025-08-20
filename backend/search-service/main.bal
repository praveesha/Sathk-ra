import ballerina/http;

service /search on new http:Listener(9092) {

    // Search Medicine by Name (Public - No Auth Required)
    resource function get medicine/[string medicineName]() returns json|error {
        // TODO: Search medicines in database by name/partial match
        // TODO: Return availability across multiple hospitals

        json response = {
            "search_term": medicineName,
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
                },
                {
                    "medicine_id": "MED005",
                    "medicine_name": "Paracetamol 250mg (Children)",
                    "category": "Pediatric Analgesic",
                    "total_available": 125,
                    "hospitals_available": 5,
                    "nearest_hospital": {
                        "hospital_id": "HOS003",
                        "name": "Lady Ridgeway Hospital",
                        "distance": "3.2km",
                        "stock": 75,
                        "contact": "+94112693711"
                    }
                }
            ],
            "search_timestamp": "2025-08-20T12:15:00Z"
        };

        return response;
    }

    // Find Hospitals by Location (Public - No Auth Required)
    resource function get hospital/[string location]() returns json|error {
        // TODO: Search hospitals by location/district
        // TODO: Include basic info and contact details

        json response = {
            "search_location": location,
            "hospitals": [
                {
                    "hospital_id": "HOS001",
                    "name": "Colombo General Hospital",
                    "address": "Colombo 08, Sri Lanka",
                    "district": "Colombo",
                    "contact": "+94112691111",
                    "services": ["Emergency", "General Medicine", "Surgery"],
                    "medicine_count": 245,
                    "status": "operational",
                    "coordinates": {
                        "latitude": 6.9271,
                        "longitude": 79.8612
                    }
                },
                {
                    "hospital_id": "HOS002",
                    "name": "National Hospital of Sri Lanka",
                    "address": "Colombo 10, Sri Lanka",
                    "district": "Colombo",
                    "contact": "+94112691222",
                    "services": ["Emergency", "Cardiology", "Neurology"],
                    "medicine_count": 380,
                    "status": "operational",
                    "coordinates": {
                        "latitude": 6.9154,
                        "longitude": 79.8572
                    }
                }
            ],
            "total_results": 2
        };

        return response;
    }

    // Advanced Search with Filters (Public)
    resource function get advanced(http:Request req) returns json|error {
        // TODO: Extract query parameters for advanced search
        // Filters: medicine_name, category, location, max_distance, min_stock

        json response = {
            "filters_applied": {
                "medicine_name": "insulin",
                "location": "colombo",
                "max_distance": "10km",
                "min_stock": 10
            },
            "results": [
                {
                    "medicine_id": "MED010",
                    "medicine_name": "Insulin (Human)",
                    "category": "Diabetes Medication",
                    "hospitals": [
                        {
                            "hospital_id": "HOS001",
                            "name": "Colombo General Hospital",
                            "stock": 45,
                            "distance": "2.5km",
                            "last_updated": "2025-08-20T10:30:00Z"
                        }
                    ]
                }
            ],
            "total_results": 1
        };

        return response;
    }

    // Get Popular/Frequently Searched Medicines (Public)
    resource function get popular() returns json|error {
        // TODO: Fetch frequently searched medicines from analytics

        json response = {
            "popular_medicines": [
                {
                    "medicine_name": "Paracetamol",
                    "search_count": 1250,
                    "availability_percentage": 85
                },
                {
                    "medicine_name": "Amoxicillin",
                    "search_count": 890,
                    "availability_percentage": 72
                },
                {
                    "medicine_name": "Insulin",
                    "search_count": 645,
                    "availability_percentage": 45
                }
            ],
            "last_updated": "2025-08-20T00:00:00Z"
        };

        return response;
    }
}
