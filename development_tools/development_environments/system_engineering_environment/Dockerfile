FROM ghcr.io/renn0xtek9/robot_base_image:0.0.1
LABEL org.opencontainers.image.source=https://github.com/renn0xtek9/robot
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install plantuml -y
RUN pipx install mkdocs
RUN pipx inject mkdocs pymdown-extensions mkdocs-material
