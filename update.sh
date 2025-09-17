#!/bin/bash

# Clockit Agent Updater
# This script updates the Clockit Agent to the latest version

set -e

echo "🔄 Updating Clockit Agent..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if running from the correct directory
INSTALL_DIR="$HOME/clockit-agent"
CURRENT_DIR="$(pwd)"

if [ "$CURRENT_DIR" != "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}⚠️  You are not in the installation directory.${NC}"
    
    if [ ! -f "docker-compose.yml" ] || [ ! -f ".env" ]; then
        echo -e "${RED}❌ Required files not found in current directory.${NC}"
        echo -e "This script should be run from the clockit-agent installation directory."
        
        # Ask if they want to go to the default directory
        read -p "Do you want to go to $INSTALL_DIR and continue? (y/n): " choice
        case "$choice" in
            y|Y)
                echo -e "${YELLOW}📂 Changing to $INSTALL_DIR${NC}"
                cd "$INSTALL_DIR" || { echo -e "${RED}❌ Failed to change directory.${NC}"; exit 1; }
                ;;
            *)
                echo -e "${RED}❌ Update cancelled.${NC}"
                exit 1
                ;;
        esac
    else
        echo -e "${YELLOW}ℹ️  Continuing with update in current directory: $CURRENT_DIR${NC}"
    fi
fi

# Check if Docker is running
if ! docker info &> /dev/null; then
    echo -e "${RED}❌ Docker is not running. Please start Docker first.${NC}"
    exit 1
fi

# Backup the .env file
echo -e "${YELLOW}💾 Backing up configuration...${NC}"
if [ -f .env ]; then
    cp .env .env.backup
    echo -e "${GREEN}✅ Configuration backed up to .env.backup${NC}"
fi

# Download the latest .env.example as the new .env
echo -e "${BLUE}⬇️  Downloading latest .env.example...${NC}"
curl -fsSL https://raw.githubusercontent.com/Zukizuk/composer/main/.env.example -o .env

# Check if download was successful
if [ ! -f .env ]; then
    echo -e "${RED}❌ Failed to download the latest .env.example${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Updated .env with latest template${NC}"
echo -e "${YELLOW}⚠️  Please review and update .env with your specific configuration values.${NC} Check .env.backup for previous settings."
echo -e "${BLUE}⬇️  Downloading latest docker-compose.yml...${NC}"
curl -fsSL https://raw.githubusercontent.com/Zukizuk/composer/main/docker-compose.yml -o docker-compose.yml.new

# Check if download was successful
if [ ! -f docker-compose.yml.new ]; then
    echo -e "${RED}❌ Failed to download the latest docker-compose.yml${NC}"
    exit 1
fi

# Check for differences in the docker-compose file
echo -e "${YELLOW}🔍 Checking for changes in configuration...${NC}"
if diff -q docker-compose.yml docker-compose.yml.new &>/dev/null; then
    echo -e "${GREEN}✓ No changes in docker-compose.yml${NC}"
    rm docker-compose.yml.new
else
    echo -e "${BLUE}🆕 New version of docker-compose.yml available${NC}"
    mv docker-compose.yml.new docker-compose.yml
    echo -e "${GREEN}✅ Updated docker-compose.yml${NC}"
fi

# Pull the latest images
echo -e "${BLUE}⬇️  Pulling latest Docker images...${NC}"
docker-compose pull || { 
    # Try alternative syntax if the first one fails
    echo -e "${YELLOW}⚠️  Trying alternative Docker Compose command...${NC}"
    docker compose pull || {
        echo -e "${RED}❌ Failed to pull Docker images.${NC}"
        exit 1
    }
}

# Stop and restart the services
echo -e "${YELLOW}🔄 Restarting services with latest images...${NC}"
docker-compose down || docker compose down
docker-compose up -d || docker compose up -d

# Check if services are running
echo -e "${YELLOW}🔍 Checking if services are running...${NC}"
sleep 5
if docker-compose ps | grep -q "Up" || docker compose ps | grep -q "Up"; then
    echo -e "${GREEN}✅ Services are up and running!${NC}"
else
    echo -e "${RED}❌ Some services may not be running properly.${NC}"
    echo -e "${YELLOW}⚠️  Please check the logs with: docker-compose logs${NC}"
fi

echo ""
echo -e "${GREEN}🎉 Update complete!${NC}"
echo ""
echo -e "${YELLOW}📝 Next steps:${NC}"
echo "1. Check the logs if needed:"
echo "   docker-compose logs"
echo ""
echo "2. Access the UI at: http://localhost:3000"
echo ""
echo -e "${BLUE}ℹ️  If you encounter any issues, please check your .env configuration${NC}"
echo -e "${BLUE}ℹ️  Your previous configuration was backed up to .env.backup${NC}"
