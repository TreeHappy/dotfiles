# Use the latest Ubuntu version
FROM ubuntu:23.10

RUN apt update \
    && apt upgrade -y \
    && apt install -y --no-install-recommends \
        curl \
        sudo \
        adduser \
        passwd \
        ca-certificates \
        xz-utils \
    && update-ca-certificates

ARG username="halcyon"
RUN useradd --no-log-init --create-home --groups sudo $username
RUN echo "$username ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER $username
# Podman/Docker doesn't set $USER in USER instruction, and it makes failure of home-manager activation
# https://stackoverflow.com/questions/54411218/docker-why-isnt-user-environment-variable-set
ENV USER=$username

WORKDIR /home/$username
COPY --chmod=0777 bootstrap.sh .
COPY --chmod=0777 dotfiles/ /home/$username/.config/home-manager/


