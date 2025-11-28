.PHONY: help setup up down restart migrate logs test docs

# Default command when just running `make`
help:
	@echo "🏗️  Larapipline Development Commands"
	@echo ""
	@echo "  make setup      - Run application setup just for the first time"
	@echo "  make up         - Start all containers"
	@echo "  make down       - Stop all containers"
	@echo "  make restart    - Restart all containers"
	@echo "  make migrate    - Run database migrations"
	@echo "  make logs       - View application logs"
	@echo "  make test       - Run tests"
	@echo "  make docs       - Generate API documentation"
	@echo "  make fresh      - refresh the database and run migrations"
	@echo "  make oc         - Optimize clear"
	@echo ""

# Setup application
setup:
	@echo "🏗️  Setting up Larapipline application..."
	cp .env.example .env
	cd backend && cp .env.example .env
	cd backend && composer install
	cd backend && npm install
	cd backend && php artisan key:generate
	cd backend && php artisan l5-swagger:generate
	cd backend && php artisan storage:link

	@echo "📝 Updating /etc/hosts with required domains..."
	@if ! grep -q "larapipline.test" /etc/hosts; then \
		echo "127.0.0.1 larapipline.test" | sudo tee -a /etc/hosts > /dev/null; \
		echo "➕ Added larapipline.test"; \
	else \
		echo "✔ larapipline.test already exists"; \
	fi
	@if ! grep -q "app.larapipline.test" /etc/hosts; then \
		echo "127.0.0.1 app.larapipline.test" | sudo tee -a /etc/hosts > /dev/null; \
		echo "➕ Added app.larapipline.test"; \
	else \
		echo "✔ app.larapipline.test already exists"; \
	fi

	@echo "✅ Setup complete! You can now run 'make up' to start the application."

# Start development environment
up:
	@echo "🚀 Starting Larapipline development environment..."
	docker compose -f docker-compose.yml up -d
	@echo "⏳ Waiting for services to be fully up..."
	@echo "Environment started ✅"
	@echo "Backend: http://larapipline.test"
	@echo "MinIO Console: http://larapipline.test:9000"
	@echo "Mailpit: http://larapipline.test:8025"
	@echo "Telescope: http://larapipline.test/telescope"
	@echo "Swagger UI: http://larapipline.test/api/v1/documentation"
	@echo "Horizon: http://larapipline.test/horizon"

# Stop development environment
down:
	@echo "🛑 Stopping Larapipline development environment..."
	docker compose -f docker-compose.yml down

# Restart development environment
restart: down up

# Run database migrations
migrate:
	@echo "🛠️  Running database migrations..."
	docker compose -f docker-compose.yml exec backend php artisan migrate --force --seed

# View logs
logs:
	@echo "📝 Viewing application logs..."
	docker compose -f docker-compose.yml logs -f backend

# Run tests
test:
	@echo "🧪 Running tests..."
	docker compose -f docker-compose.yml exec backend php artisan test

# Generate API documentation
docs:
	@echo "📚 Generating API documentation..."
	docker compose -f docker-compose.yml exec backend php artisan l5-swagger:generate

# Refresh the database and run migrations
fresh:
	@echo "🔄 Refreshing the database and running migrations..."
	docker compose -f docker-compose.yml exec backend php artisan migrate:fresh --seed

# Optimize clear
oc:
	@echo "⚙️  Running optimize clear..."
	docker compose -f docker-compose.yml exec backend php artisan o:c