FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim

WORKDIR /app

ENV PYTHONPATH="/app:/"

COPY pyproject.toml .
RUN uv pip install --system --no-cache-dir -r pyproject.toml

COPY . .

# Указываем порт, который будет использоваться
EXPOSE 8000

# Команда для запуска Litestar
CMD ["uv", "run", "litestar", "--app", "src.main:app", "run", "--host", "0.0.0.0", "--port", "8000"]