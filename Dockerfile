FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim

# Рабочая директория
WORKDIR /app

# Чтобы Python писал логи сразу, а не буферизовал
ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH="/app:/"

# Устанавливаем зависимости
COPY pyproject.toml .
RUN uv pip install --system --no-cache-dir -r pyproject.toml

# Копируем весь проект
COPY . .

# Создаем папку для логов
RUN mkdir -p /app/logs && chmod 777 /app/logs

# Команда запуска приложения
CMD sh -c "alembic upgrade head && uvicorn src.main:app --host 0.0.0.0 --port 8000"
