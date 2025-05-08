# Base image with Ubuntu
FROM ubuntu:24.04

# Update and install essential packages
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    build-essential \
    software-properties-common \
    default-jre \
    parallel \
    r-base \
    python3-setuptools \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install FLASH (v1.2.11+)
RUN wget https://github.com/dstreett/FLASH2/archive/refs/tags/2.2.00.tar.gz && \
    tar -xzf 2.2.00.tar.gz && \
    cd FLASH2-2.2.00 && \
    make && \
    mv flash2 flash && \
    cp flash /usr/local/bin && \
    cd .. && rm -rf FLASH2-2.2.00 2.2.00.tar.gz

# Install VSEARCH v2.14.2+
RUN wget https://github.com/torognes/vsearch/releases/download/v2.30.0/vsearch-2.30.0-linux-x86_64.tar.gz && \
    tar -xzf vsearch-2.30.0-linux-x86_64.tar.gz && \
    cp vsearch-2.30.0-linux-x86_64/bin/vsearch /usr/local/bin && \
    rm -rf vsearch-2.30.0-linux-x86_64*

# Default shell
CMD ["/bin/bash"]
