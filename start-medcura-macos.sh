#!/bin/bash

# MedCura - Startup Script (macOS)
# This script starts all microservices for the MedCura platform

echo "🏥 Starting MedCura - Emergency Medicine & Rural Health Access Platform"
echo "========================================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to check if port is available
check_port() {
    if lsof -Pi :$1 -sTCP:LISTEN -t >/dev/null ; then
        echo -e "${RED}Port $1 is already in use${NC}"
        return 1
    else
        return 0
    fi
}

# Check all required ports
echo -e "${BLUE}Checking ports...${NC}"
ports=(9090 9091 9092 9093 3000)
for port in "${ports[@]}"; do
    if ! check_port $port; then
        echo -e "${RED}Please free up port $port and try again${NC}"
        exit 1
    fi
done

echo -e "${GREEN}All ports are available${NC}"
echo ""

# Start Backend Services
echo -e "${BLUE}Starting Backend Services...${NC}"

# Hospital Service (Port 9090)
echo -e "${YELLOW}Starting Hospital Service on port 9090...${NC}"
cd backend/hospital-service
osascript -e "tell application \"Terminal\" to do script \"cd $(pwd) && bal run\"" &
sleep 2

# Inventory Service (Port 9091) 
echo -e "${YELLOW}Starting Inventory Service on port 9091...${NC}"
cd ../inventory-service
osascript -e "tell application \"Terminal\" to do script \"cd $(pwd) && bal run\"" &
sleep 2

# Search Service (Port 9092)
echo -e "${YELLOW}Starting Search Service on port 9092...${NC}"
cd ../search-service  
osascript -e "tell application \"Terminal\" to do script \"cd $(pwd) && bal run\"" &
sleep 2

# Notification Service (Port 9093)
echo -e "${YELLOW}Starting Notification Service on port 9093...${NC}"
cd ../notification-service
osascript -e "tell application \"Terminal\" to do script \"cd $(pwd) && bal run\"" &
sleep 2

# Start Frontend
echo -e "${YELLOW}Starting Frontend on port 3000...${NC}"
cd ../../frontend
osascript -e "tell application \"Terminal\" to do script \"cd $(pwd) && npm run dev\"" &

sleep 3

echo ""
echo -e "${GREEN}🎉 MedCura is starting up!${NC}"
echo ""
echo "Services:"
echo -e "  🏥 Hospital Service:     ${BLUE}http://localhost:9090${NC}"
echo -e "  📦 Inventory Service:    ${BLUE}http://localhost:9091${NC}"  
echo -e "  🔍 Search Service:       ${BLUE}http://localhost:9092${NC}"
echo -e "  🔔 Notification Service: ${BLUE}http://localhost:9093${NC}"
echo -e "  🌐 Frontend:             ${BLUE}http://localhost:3000${NC}"
echo ""
echo -e "${YELLOW}Wait a few seconds for all services to start up completely.${NC}"
echo -e "${GREEN}Then visit http://localhost:3000 to access MedCura!${NC}"
echo ""
echo "Individual service commands:"
echo "  cd backend/hospital-service && bal run"
echo "  cd backend/inventory-service && bal run"  
echo "  cd backend/search-service && bal run"
echo "  cd backend/notification-service && bal run"
echo "  cd frontend && npm run dev"
echo ""
echo "Press Ctrl+C to stop this script (services will continue running)"

# Keep script running
wait
