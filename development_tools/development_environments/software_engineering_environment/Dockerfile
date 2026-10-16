FROM 192.168.178.39:5443/robot_base_image:0.0.1
LABEL org.opencontainers.image.source=https://github.com/renn0xtek9/robot
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install locales ansible -y
RUN sudo locale-gen en_US.UTF-8 

# Install latest cmake
WORKDIR /tmp 
RUN wget https://github.com/Kitware/CMake/releases/download/v4.4.4/cmake-4.4.4-linux-x86_64.tar.gz
RUN tar -xf cmake-4.4.4-linux-x86_64.tar.gz
RUN mv cmake-4.4.4-linux-x86_64 /opt/cmake
ENV PATH="$PATH:/opt/cmake/bin/"

# Cross compiling tools for raspberry.
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    g++-aarch64-linux-gnu \
    gcc-aarch64-linux-gnu \
    binutils-aarch64-linux-gnu \
    ninja-build \
    pkg-config \
    file

# Install our own tooling
RUN apt-get install -y hil-sysroot

RUN rm -rf /var/lib/apt/lists/*
WORKDIR /home/ubuntu
