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

# Handle existing installation
INSTALL_DIR="$HOME/clockit-agent"
BACKUP_RESTORED=false

if [ -d "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}📂 Existing Clockit installation found at $INSTALL_DIR${NC}"
    
    # Check if there's an existing .env file to backup
    if [ -f "$INSTALL_DIR/.env" ]; then
        # Create backup directory with timestamp
        BACKUP_DIR="/tmp/clockit-backup-$(date +%Y%m%d_%H%M%S)"
        mkdir -p "$BACKUP_DIR"
        
        echo -e "${YELLOW}💾 Backing up existing environment variables to $BACKUP_DIR${NC}"
        cp "$INSTALL_DIR/.env" "$BACKUP_DIR/.env.backup"
        echo -e "${GREEN}✅ Environment variables backed up successfully${NC}"
        
        # Remove the existing installation directory
        echo -e "${YELLOW}🗑️  Removing existing installation for clean reinstall...${NC}"
        rm -rf "$INSTALL_DIR"
        echo -e "${GREEN}✅ Existing installation removed${NC}"
    else
        echo -e "${YELLOW}⚠️  No .env file found in existing installation${NC}"
        echo -e "${YELLOW}🗑️  Removing existing installation for clean reinstall...${NC}"
        rm -rf "$INSTALL_DIR"
        echo -e "${GREEN}✅ Existing installation removed${NC}"
    fi
else
    echo -e "${YELLOW}📁 No existing installation found${NC}"
fi

echo -e "${YELLOW}📁 Creating installation directory: $INSTALL_DIR${NC}"
mkdir -p "$INSTALL_DIR"

# NOTE: We don't change directory since when run with curl | bash, 
# directory changes don't persist to the user's shell

# Download docker-compose.yml
echo -e "${YELLOW}⬇️  Downloading docker-compose.yml...${NC}"
curl -fsSL https://raw.githubusercontent.com/Zukizuk/composer/main/docker-compose.yml -o "$INSTALL_DIR/docker-compose.yml"

# Always download fresh .env template
echo -e "${YELLOW}⬇️  Downloading sample .env file...${NC}"
curl -fsSL https://raw.githubusercontent.com/Zukizuk/composer/main/.env.example -o "$INSTALL_DIR/.env"

# Restore backup as .env.backup for reference
if [ -n "$BACKUP_DIR" ] && [ -f "$BACKUP_DIR/.env.backup" ]; then
    echo -e "${YELLOW}🔄 Placing backed up environment variables as .env.backup for reference...${NC}"
    cp "$BACKUP_DIR/.env.backup" "$INSTALL_DIR/.env.backup"
    echo -e "${GREEN}✅ Previous environment variables saved as .env.backup${NC}"
    BACKUP_RESTORED=true
    
    # Clean up backup directory
    rm -rf "$BACKUP_DIR"
    echo -e "${GREEN}✅ Backup directory cleaned up${NC}"
fi

# Download update script
echo -e "${YELLOW}⬇️  Downloading update script...${NC}"
curl -fsSL https://raw.githubusercontent.com/Zukizuk/composer/main/update.sh -o "$INSTALL_DIR/update.sh"
chmod +x "$INSTALL_DIR/update.sh"
echo -e "${GREEN}✅ Update script downloaded and made executable${NC}"

# Download README for local reference
echo -e "${YELLOW}⬇️  Downloading README for local reference...${NC}"
curl -fsSL https://raw.githubusercontent.com/Zukizuk/composer/main/README.md -o "$INSTALL_DIR/README.md"
echo -e "${GREEN}✅ Documentation downloaded${NC}"

echo -e "${GREEN}✅ Files downloaded successfully!${NC}"
echo ""

if [ "$BACKUP_RESTORED" = true ]; then
    echo -e "${GREEN}🔄 Your previous environment variables have been saved as .env.backup for reference!${NC}"
    echo -e "${YELLOW}📝 Next steps:${NC}"
    echo "1. Change to the installation directory:"
    echo -e "   ${GREEN}cd ~/clockit-agent${NC}"
    echo ""
    echo "2. Edit the .env file with your configuration:"
    echo -e "   ${GREEN}nano .env${NC}"
    echo -e "   ${BLUE}💡 You can reference your old settings in .env.backup${NC}"
    echo ""
    echo "3. Start the services:"
    echo "   docker-compose up -d"
    echo ""
    echo "4. Access the UI at: http://localhost:3000"
else
    echo -e "${YELLOW}📝 Next steps:${NC}"
    echo "1. Change to the installation directory:"
    echo -e "   ${GREEN}cd ~/clockit-agent${NC}"
    echo ""
    echo "2. Edit the .env file with your configuration:"
    echo "   nano .env"
    echo ""
    echo "3. Start the services:"
    echo "   docker-compose up -d"
    echo ""
    echo "4. Access the UI at: http://localhost:3000"
fi
echo ""
echo -e "${BLUE}ℹ️  For detailed instructions and updates, check the README.md in your installation directory${NC}"
echo -e "${BLUE}ℹ️  To update Clockit Agent in the future, simply run: ./update.sh${NC}"
echo ""
echo -e "${GREEN}🎉 Installation complete!${NC}"
