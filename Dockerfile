FROM focker.ir/library/python:3.12-slim

USER root

# Install system packages with apt-get (Debian-based)
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    python3-venv \
    python3-pip \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /code

# Create virtual environment
RUN python3 -m venv /code/venv

# Install dependencies
COPY code/requirements.txt /code/requirements.txt
RUN mkdir -p /code/pip_cache
RUN /code/venv/bin/pip install --upgrade pip
RUN /code/venv/bin/pip install --cache-dir=/code/pip_cache -r /code/requirements.txt

# Install n8n explicitly
RUN /code/venv/bin/pip install n8n

# Specify the correct command to run n8n
CMD ["/code/venv/bin/n8n"]

