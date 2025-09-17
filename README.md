# Clockit Agent 🚀

A simple Docker Compose setup to run Clockit Agent with its web UI.

## Quick Start

### One-line Installation

```bash
curl -fsSL https://raw.githubusercontent.com/Zukizuk/composer/main/install.sh | bash
```

> **Note for Windows users**: Run this command in Git Bash, WSL, or another bash-compatible shell.

After installation, change to the installation directory:
```bash
cd ~/clockit-agent
```

This will:
- Download the necessary files to `~/clockit-agent/`
- Set up the environment
- Provide next steps for configuration

### Manual Installation

1. **Download the files:**
   ```bash
   mkdir clockit-agent && cd clockit-agent
   curl -O https://raw.githubusercontent.com/Zukizuk/composer/main/docker-compose.yml
   curl -O https://raw.githubusercontent.com/Zukizuk/composer/main/.env.example
   cp .env.example .env
   ```

2. **Configure environment:**
   ```bash
   nano .env
   ```
   Fill in your API keys and configuration.

3. **Start the services:**
   ```bash
   docker-compose up -d
   ```

4. **Access the application:**
   - UI: http://localhost:3000
   - API: http://localhost:2024

## After Installation Guide

Once you've installed Clockit Agent (either via the one-line installer or manually), follow these steps:

### 1. Navigate to Installation Directory
```bash
cd ~/clockit-agent
```

### 2. Configure Your Environment
Edit the `.env` file with your configuration:
```bash
nano .env
```
Fill in your API keys and other required settings.

### 3. Start the Services
```bash
docker-compose up -d
```

### 4. Access the Application
- **Web UI**: http://localhost:3000
- **API**: http://localhost:2024

### 5. Check Status
```bash
docker-compose ps
```

### 6. View Logs (if needed)
```bash
docker-compose logs -f
```

## Updating Clockit Agent

### One-line Update (Recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/Zukizuk/composer/main/update.sh | bash
```

This will automatically:
- Download and run the latest update script
- Back up your current configuration
- Download latest files
- Pull new Docker images
- Restart services
- Verify everything is running

### Alternative Update Methods

#### Using Local Update Script
If you used our installer, you have an update script:
```bash
cd ~/clockit-agent
./update.sh
```

#### Manual Update
```bash
cd ~/clockit-agent
docker-compose pull
docker-compose down
docker-compose up -d
```

## Services

- **agent-chat-ui**: Web interface for interacting with the agent
- **clockit-agent**: The main agent service

## Requirements

- Docker
- Docker Compose

## Platform Support

### Linux/macOS
The scripts work natively on Linux and macOS systems.

### Windows
For Windows users:
1. Install Docker Desktop for Windows
2. Use one of the following options to run the installation script:
   - **Option 1**: Install [Git Bash](https://gitforwindows.org/) and run the script through it
   - **Option 2**: Use [WSL (Windows Subsystem for Linux)](https://docs.microsoft.com/en-us/windows/wsl/install)
   - **Option 3**: Use [Cygwin](https://www.cygwin.com/)

The scripts must be run in a bash-compatible shell.

## Usage

### Start services
```bash
docker-compose up -d
```

### Stop services
```bash
docker-compose down
```

### View logs
```bash
docker-compose logs -f
```

### Update to latest version
```bash
./update.sh
```
(See the "Updating Clockit Agent" section above for detailed instructions)

## Configuration

The application uses environment variables defined in the `.env` file. Make sure to configure all required variables before starting the services.

## Troubleshooting

### Services won't start
1. Check if ports 3000 and 2024 are available
2. Verify your `.env` configuration
3. Check logs: `docker-compose logs`

### Can't access the UI
1. Ensure the service is running: `docker-compose ps`
2. Check if port 3000 is accessible
3. Verify firewall settings if running on a remote server

## Support

For issues and questions, please visit the [GitHub repository](https://github.com/Zukizuk/composer).
