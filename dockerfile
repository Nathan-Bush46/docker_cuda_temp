# Use the CUDA image as the base
FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

# Install Git, Node.js, and utilities that VS Code might need.
RUN apt-get update && \
    apt-get install -y git curl nodejs npm && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Update system, install common utilities, Python tools, and CUDA dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
      software-properties-common \
      wget \
      curl \
      python3-dev \
      python3-pip \
      python3-wheel \
      python3-setuptools && \
    python3 -m pip install --upgrade pip && \
    \
    # Update CUDA Linux GPG repository key
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb && \
    dpkg -i cuda-keyring_1.0-1_all.deb && \
    rm cuda-keyring_1.0-1_all.deb && \
    \
    # Configure and install cuDNN from the CUDA repository
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin && \
    mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/3bf863cc.pub && \
    add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /" -y && \
    apt-get update && \
    apt-get install -y \
      libcudnn8=8.9.0.*-1+cuda11.8 \
      libcudnn8-dev=8.9.0.*-1+cuda11.8 && \
    \
    # Install recommended packages
    apt-get install -y \
      zlib1g \
      g++ \
      freeglut3-dev \
      libx11-dev \
      libxmu-dev \
      libxi-dev \
      libglu1-mesa \
      libglu1-mesa-dev \
      libfreeimage-dev && \
    \
    # Clean up
    pip3 cache purge && \
    apt-get autoremove -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variable as needed
ENV LD_LIBRARY_PATH=/usr/local/lib/python3.10/dist-packages/nvidia/cuda_nvrtc/lib:$LD_LIBRARY_PATH
