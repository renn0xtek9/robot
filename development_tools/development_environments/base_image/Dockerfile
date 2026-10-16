FROM ubuntu:24.04

LABEL org.opencontainers.image.source=https://github.com/renn0xtek9/robot
ENV DEBIAN_FRONTEND=noninteractive

# Base tools
RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    gnupg \
    bash-completion \
    curl \
    gnupg \
    sudo \
    git \
    git-lfs \
    docker.io \ 
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install GitHub CLI repository
RUN mkdir -p -m 755 /etc/apt/keyrings \
    && wget -nv -O /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    > /etc/apt/sources.list.d/github-cli.list

RUN apt-get update && apt-get install -y gh

# Install private package repository client
RUN mkdir -p /etc/apt/certs
COPY vault/ubuntu_mhaselbauer_apt_client.crt /etc/apt/certs/
COPY vault/ubuntu_mhaselbauer_apt_client.key /etc/apt/certs/
COPY vault/rootCA_mhaselbauer_apt.crt /etc/apt/certs/

RUN update-ca-certificates \
    && printf '%s\n' \
    'Acquire::https::192.168.178.39::CAInfo "/etc/apt/certs/rootCA_mhaselbauer_apt.crt";' \
    'Acquire::https::192.168.178.39::SslCert "/etc/apt/certs/ubuntu_mhaselbauer_apt_client.crt";' \
    'Acquire::https::192.168.178.39::SslKey "/etc/apt/certs/ubuntu_mhaselbauer_apt_client.key";' \
    > /etc/apt/apt.conf.d/80robot-private-repository

RUN echo "deb [signed-by=/etc/apt/mhaselbauer-apt.asc] https://192.168.178.39 robot release" \
    > /etc/apt/sources.list.d/robot.list
RUN echo "deb [signed-by=/etc/apt/mhaselbauer-apt.asc] https://192.168.178.39 robot sdk" \
    >> /etc/apt/sources.list.d/robot.list

RUN curl \
    --cacert "/etc/apt/certs/rootCA_mhaselbauer_apt.crt" \
    --cert "/etc/apt/certs/ubuntu_mhaselbauer_apt_client.crt" \
    --key "/etc/apt/certs/ubuntu_mhaselbauer_apt_client.key" \
    "https://192.168.178.39/repo-public.asc" \
    -o "/etc/apt/mhaselbauer-apt.asc"

RUN chown root:root /etc/apt/mhaselbauer-apt.asc
RUN chmod 0644 /etc/apt/mhaselbauer-apt.asc

# Install task
RUN curl -1sLf 'https://dl.cloudsmith.io/public/task/task/setup.deb.sh' | sudo -E bash
RUN apt-get update 
RUN apt-get install task
RUN rm -rf /var/lib/apt/lists/*

# Allow ubuntu user to sudo without password
RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu \
    && chmod 0440 /etc/sudoers.d/ubuntu
