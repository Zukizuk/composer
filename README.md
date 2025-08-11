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
# If you installed using our script, just run:
./update.sh

# Or manually:
docker-compose pull
docker-compose up -d
```

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
