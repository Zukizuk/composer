# Clockit Agent 🚀

A simple Docker Compose setup to run Clockit Agent with its web UI.

## Quick Start

### One-line Installation

```bash
curl -fsSL https://raw.githubusercontent.com/Zukizuk/composer/main/install.sh | bash
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
