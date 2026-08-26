# ---- Base image ----
FROM python:3.12-slim

# ---- Set working directory inside the container ----
WORKDIR /code

# Upgrade pip, setuptools, and msgpack to patch known vulnerabilities
# present in the base image's bundled versions
RUN pip install --no-cache-dir --upgrade --force-reinstall pip "setuptools>=78.1.1" "msgpack>=1.0.8"

# ---- Install dependencies first (better layer caching) ----
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ---- Copy application code ----
COPY app ./app

# ---- Create a non-root user and switch to it ----
RUN useradd --create-home --shell /bin/bash appuser
USER appuser

# ---- Expose the port the app runs on ----
EXPOSE 8000

# ---- Run the app using uvicorn ----
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
