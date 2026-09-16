FROM 192.168.178.39:5443/robot_base_image:0.0.1
LABEL org.opencontainers.image.source=https://github.com/renn0xtek9/robot
ENV DEBIAN_FRONTEND=noninteractive
ENV VENV_PATH=/opt/venv
ENV PATH="${VENV_PATH}/bin:${PATH}"

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

# Install private package repository
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

RUN apt-get update
RUN apt-get install plantuml python3-venv -y && rm -rf /var/lib/apt/lists/*

# We use python3-pip instead of pipx to enable tools for all users
# (Remember that user on GitHub CI will be "root")
RUN python3 -m venv ${VENV_PATH}

RUN ${VENV_PATH}/bin/pip install --upgrade pip

RUN ${VENV_PATH}/bin/pip install --no-cache-dir \
    mkdocs \
    pymdown-extensions \
    mkdocs-material \
    mkdocs-panzoom-plugin

RUN alias reqid='cat /proc/sys/kernel/random/uuid  |sed "s/\([[:alnum:]]\)-.*/\1/"' 
