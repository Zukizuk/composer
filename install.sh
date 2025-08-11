#!/bin/bash

# Clockit Agent Installer
# This script downloads and runs the Clockit Agent with UI

set -e

echo "🚀 Installing Clockit Agent..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker is not installed. Please install Docker first.${NC}"
    echo "Visit: https://docs.docker.com/get-docker/"
    exit 1
fi

# Check if Docker Compose is available
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo -e "${RED}❌ Docker Compose is not available. Please install Docker Compose.${NC}"
    exit 1
fi

# Create directory
INSTALL_DIR="$HOME/clockit-agent"
echo -e "${YELLOW}📁 Creating installation directory: $INSTALL_DIR${NC}"
mkdir -p "$INSTALL_DIR"

# Change to the installation directory
echo -e "${YELLOW}📂 Changing to installation directory: $INSTALL_DIR${NC}"
cd "$INSTALL_DIR" || { echo -e "${RED}❌ Failed to change to installation directory.${NC}"; exit 1; }

# Download docker-compose.yml
echo -e "${YELLOW}⬇️  Downloading docker-compose.yml...${NC}"
curl -fsSL https://raw.githubusercontent.com/Zukizuk/composer/main/docker-compose.yml -o docker-compose.yml

# Download sample .env if it doesn't exist
if [ ! -f .env ]; then
    echo -e "${YELLOW}⬇️  Downloading sample .env file...${NC}"
    curl -fsSL https://raw.githubusercontent.com/Zukizuk/composer/main/.env.example -o .env
    echo -e "${YELLOW}⚠️  Please edit the .env file with your configuration before running.${NC}"
fi

# Download update script
echo -e "${YELLOW}⬇️  Downloading update script...${NC}"
curl -fsSL https://raw.githubusercontent.com/Zukizuk/composer/main/update.sh -o update.sh
chmod +x update.sh
echo -e "${GREEN}✅ Update script downloaded and made executable${NC}"

echo -e "${GREEN}✅ Files downloaded successfully!${NC}"
echo ""
echo -e "${YELLOW}📝 Next steps:${NC}"
echo "1. Edit the .env file with your configuration:"
echo "   nano .env"
echo ""
echo "2. Start the services:"
echo "   docker-compose up -d"
echo ""
echo "3. Access the UI at: http://localhost:3000"
echo ""
echo -e "${BLUE}ℹ️  To update Clockit Agent in the future, simply run:${NC}"
echo "   ./update.sh"
echo ""
echo -e "${GREEN}🎉 Installation complete!${NC}"
