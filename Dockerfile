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

# RUN curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux \
#   --extra-conf "sandbox = false" \
#   --init none \
#   --no-confirm
#
# ENV PATH="${PATH}:/nix/var/nix/profiles/default/bin"
#
# https://github.com/NixOS/nix/issues/3435#issuecomment-1642654775
# This is... but other solutins can't avoid following error
# error: could not set permissions on '/nix/var/nix/profiles/per-user' to 755: Operation not permitted
# RUN sudo chown --recursive $username /nix
WORKDIR /home/$username
COPY --chown=$username bootstrap.sh .
COPY --chown=$username dotfiles/ /home/$username/.config/home-manager/


