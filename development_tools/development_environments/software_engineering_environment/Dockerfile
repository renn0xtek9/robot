FROM 192.168.178.39:5443/robot_base_image:0.0.1
LABEL org.opencontainers.image.source=https://github.com/renn0xtek9/robot
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install locales ansible -y
RUN sudo locale-gen en_US.UTF-8 

RUN rm -rf /var/lib/apt/lists/*
