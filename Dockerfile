FROM python:3.12-slim

# Install git (needed to clone) and dependencies for pyenv just in case
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev \
    && rm -rf /var/lib/apt/lists/*

# Set up PyLingual source directory
WORKDIR /opt/pylingual

# Clone the repository
RUN git clone https://github.com/syssec-utd/pylingual .

# Install Poetry and project dependencies globally inside the container
RUN pip install "poetry>=2.0"
RUN poetry config virtualenvs.create false && poetry install

# Set up the working directory where we will mount your files
WORKDIR /workspace

# Set the entrypoint to the PyLingual CLI tool
ENTRYPOINT ["pylingual"]
CMD ["--help"]
