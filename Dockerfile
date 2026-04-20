FROM ubuntu:latest

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update and install system packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    sudo \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user 'masoc' with home directory and sudo access
RUN useradd -m -s /bin/bash masoc \
    && echo "masoc ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to non-root user
USER masoc
WORKDIR /home/masoc/app

# Create virtual environment and install Flask
RUN python3 -m venv venv
ENV PATH="/home/masoc/app/venv/bin:${PATH}"

# Copy source code into the image
COPY --chown=masoc:masoc src/ src/

# Install Flask inside the venv
RUN pip install --no-cache-dir Flask

# Set Flask environment variables
ENV FLASK_APP=src/app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=5000

# Expose Flask port
EXPOSE 5000

# Default command: run the Flask app
CMD ["flask", "run"]

