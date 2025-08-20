import ballerina/http;

service /medicine on new http:Listener(9090) {

    resource function get availability(http:Caller caller, http:Request req) returns error? {
        json response = { "medicine": "Paracetamol", "stock": 45, "hospital": "Colombo General" };
        check caller->respond(response);
    }
}
