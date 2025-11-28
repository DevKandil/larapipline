# Larapipline

A modern web application with a Laravel backend and Next.js frontend, fully containerized with Docker.

## 🏗 Project Structure

- **`backend/`**: Laravel 11 application (API).
- **`frontend/`**: Next.js 15 application (UI).
- **`docker-compose.yml`**: Docker services configuration.
- **`Makefile`**: Helper commands for development.

## 🚀 Getting Started

### Prerequisites

- [Docker](https://www.docker.com/) & Docker Compose
- [Make](https://www.gnu.org/software/make/) (optional, but recommended)

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/DevKandil/larapipline.git
    cd larapipline
    ```

2.  **Setup the environment:**
    Run the setup command to copy environment files and install dependencies.
    ```bash
    make setup
    ```
    *If you don't have `make`, you can manually copy `.env.example` to `.env` in root and `backend/`, and run `composer install` in `backend/`.*

3.  **Start the application:**
    ```bash
    make up
    # OR
    docker-compose up -d
    ```

## 🐳 Services & Ports

| Service | Description | URL / Port |
| :--- | :--- | :--- |
| **Frontend** | Next.js Application | [http://localhost:3000](http://localhost:3000) |
| **Web** | Nginx (Backend Proxy) | [http://localhost](http://localhost) |
| **App** | PHP-FPM (Backend Logic) | Port 9000 (internal) |
| **Worker** | Laravel Queue Worker | Background Process |
| **PostgreSQL** | Database | Port 5432 |
| **Redis** | Cache & Queue | Port 6379 |
| **MinIO** | S3-compatible Storage | [http://localhost:9000](http://localhost:9000) (Console: :8900) |
| **Mailpit** | Email Testing | [http://localhost:8025](http://localhost:8025) |

## 🛠 Useful Commands

| Command | Description |
| :--- | :--- |
| `make up` | Start all containers |
| `make down` | Stop all containers |
| `make restart` | Restart all containers |
| `make logs` | View backend logs |
| `make migrate` | Run database migrations |
| `make fresh` | Refresh database and seed |
| `make test` | Run backend tests |
| `make docs` | Generate API documentation (Swagger) |
| `make oc` | Clear Laravel caches |

## 📝 License

This project is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
