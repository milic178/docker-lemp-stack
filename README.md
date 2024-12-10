# Simple Docker LEMP Stack Template

This repository provides a robust and optimized LEMP (Linux, Nginx, MariaDB, PHP) stack using Docker Compose. The stack includes additional services like Redis, npm, and Mailhog for a complete and modern development environment.

---

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
- [Services Included](#services-included)
- [Environment Variables](#environment-variables)
- [Usage](#usage)
- [Volumes](#volumes)
- [Ports](#ports)
- [License](#license)

---

## Overview

This LEMP stack includes:

- **Nginx**: Web server for serving the application.
- **PHP**: PHP-FPM for processing PHP code.
- **MariaDB**: MySQL-compatible database for data storage.
- **Redis**: In-memory data structure store for caching.
- **npm**: Node.js package manager for frontend tooling.

### Key Features:
- Persistent volumes for database and Redis data.
- Non-root users for increased security.
- Optimized Dockerfiles for PHP and Nginx.
- Compatibility with Laravel and Slim frameworks.

---

## Prerequisites

Ensure the following are installed on your system:

- **Docker**
- **Docker Compose**

---

## Setup Instructions

### Clone the Repository

```bash
git clone <repository-url>
cd <repository-directory>
```

### Create a `.env` File

Copy the example `.env` file and configure your environment variables:

```bash
cp .env.example .env
```

### Build and Start the Docker Containers

```bash
docker-compose up -d --build
```

### Verify Services

Check that all services are running:

```bash
docker-compose ps
```

---

## Services Included

### Overview of Services:

- **app (Nginx)**: Serves the application on port `80`.
- **mysql (MariaDB)**: Database server on port `3306`.
- **php**: PHP-FPM for running PHP code.
- **redis**: Redis server on port `6379` for caching.
- **npm**: Node.js environment for frontend development.
- **mailhog**: Captures emails for testing on ports `1025` (SMTP) and `8025` (Web UI).

---

## Environment Variables

Ensure the following variables are set in your `.env` file:

```dotenv
# Database credentials
MYSQL_DATABASE=your_database_name
MYSQL_USER=your_user
MYSQL_PASSWORD=your_password
MYSQL_ROOT_PASSWORD=your_root_password

# Redis credentials
REDIS_PASSWORD=your_redis_password

# User and group IDs for permissions
UID=1000
GID=1000
```

---

## Usage

### Start All Containers
```bash
docker-compose up -d
```

### Stop All Containers
```bash
docker-compose down
```

### Rebuild Containers
```bash
docker-compose build
```

### Run Composer Commands
Composer is accessible from the PHP container:
```bash
docker exec -it php composer install
```

### Run npm Commands
Use npm for frontend development:
```bash
docker exec -it npm npm install
```

### Run Redis CLI
To interact with the Redis server:
```bash
docker exec -it redis redis-cli
```

---

## Volumes

The stack uses named volumes for persistent data storage:

- **mysql_data**: Persists MariaDB database data.
- **redis_data**: Persists Redis data.

---

## Ports

The following ports are exposed:

| Service   | Port Mapping       |
|-----------|--------------------|
| Nginx     | `80:80`           |
| MariaDB   | `3306:3306`       |
| Redis     | `6379:6379`       |
| Mailhog   | `1025` (SMTP), `8025` (Web UI) |
| npm       | `3000`, `3001`, `5173` |

---

## License

This project is open-source and available under the MIT License.

Feel free to customize the stack to meet your specific project needs! 🚀

