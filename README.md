

# Simple Docker LEMP Stack Template

This repository provides a simple LEMP (Linux, Nginx, MariaDB, PHP) stack using Docker Compose. The stack also includes additional services such as Redis, Composer, npm, and Mailhog for a complete development environment.

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

## Overview

This LEMP stack includes:
- **Nginx**: Web server for serving the application.
- **PHP**: PHP-FPM for processing PHP code.
- **MariaDB**: MySQL-compatible database for data storage.
- **Redis**: In-memory data structure store for caching.
- **Composer**: Dependency manager for PHP.
- **npm**: Node.js package manager for frontend tooling.
- **Artisan**: For running Laravel artisan commands.
- **Mailhog**: For capturing and viewing outgoing emails during development.

## Prerequisites

Ensure that you have the following installed:
- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. Create a `.env` file and set the required environment variables:
   ```bash
   cp .env.example .env
   ```

3. Build the Docker containers:
   ```bash
   docker-compose up -d --build app
   ```

4. Verify that all services are running:
   ```bash
   docker-compose ps
   ```

## Services Included

- **app (Nginx)**: Serves the application on port 80.
- **mysql (MariaDB)**: Database server on port 3306.
- **php**: PHP-FPM for running PHP code.
- **redis**: Redis server on port 6379 for caching.
- **composer**: For managing PHP dependencies.
- **npm**: Node.js environment for frontend development.
- **artisan**: Runs Laravel artisan commands.
- **mailhog**: Captures emails for testing on ports 1025 (SMTP) and 8025 (web UI).

## Environment Variables

Ensure the following variables are set in your `.env` file:
```dotenv
MYSQL_DATABASE=your_database_name
MYSQL_USER=your_user
MYSQL_PASSWORD=your_password
MYSQL_ROOT_PASSWORD=your_root_password
REDIS_PASSWORD=your_redis_password
```

## Usage

- **Start all containers**:
  ```bash
  docker-compose up -d app
  ```

- **Stop all containers**:
  ```bash
  docker-compose down
  ```

- **Rebuild containers**:
  ```bash
  docker-compose build
  ```

- **Run Artisan commands**:
  ```bash
  docker-compose run --rm artisan <command>
  ```

- **Install Composer dependencies**:
  ```bash
  docker-compose run --rm composer <command>
  ```

- **Run npm commands**:
  ```bash
  docker-compose run --rm npm run dev
  ```

## Compiling Assets

This configuration supports compiling assets using both Laravel Mix and Vite. To get started, you need to modify the `package.json` file to include `--host 0.0.0.0` at the end of your development command. For example, in a Laravel project using Vite, your `package.json` should look like this:

```json
"scripts": {
  "dev": "vite --host 0.0.0.0",
  "build": "vite build"
},
```

### Steps to Compile Assets

1. **Install dependencies**:
   ```bash
   docker-compose run --rm npm install
   ```

2. **Start the development server with hot-module reloading**:
   ```bash
   docker-compose run --rm --service-ports npm run dev
   ```

After running these commands, you should be able to use the `@vite` directives to enable hot-module reloading in your local Laravel application.

### Building for Production

To build your assets for production, run:
```bash
docker-compose run --rm npm run build
```


## Volumes

- `mysql_data`: Persists database data.
- `redis_data`: Persists Redis data.

## Ports

| Service     | Port Mapping       |
|-------------|---------------------|
| Nginx       | 80:80              |
| MariaDB     | 3306:3306          |
| Redis       | 6379:6379          |
| Mailhog     | 1025 (SMTP), 8025 (Web UI) |
| npm         | 3000, 3001, 5173   |

## License

This project is open-source and available under the [MIT License](LICENSE).

---

Feel free to customize further to meet any specific project needs!
