FROM 192.168.178.39:5443/robot_base_image:0.0.1
LABEL org.opencontainers.image.source=https://github.com/renn0xtek9/robot
ENV DEBIAN_FRONTEND=noninteractive
ENV VENV_PATH=/opt/venv
ENV PATH="${VENV_PATH}/bin:${PATH}"

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
