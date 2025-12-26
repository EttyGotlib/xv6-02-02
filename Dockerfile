# Dockerfile
# DESCRIPTION: Run xv6 inside Docker container
# STUDENT NAME: ESTER EKSHEIN
# STUDENT ID: 325458602

FROM ubuntu:16.04

# Update packages and install required dependencies
# --- FIX ADDED HERE ---
# Added build-essential, gcc-multilib, qemu-system, make
# These are REQUIRED for building and running xv6
RUN apt-get -qq update && \
    apt-get install -y --no-install-recommends --reinstall ca-certificates \
        git \
        build-essential \
        gcc-multilib \
        qemu-system \
        make \
    && git clone https://github.com/mit-pdos/xv6-public.git xv6 \
    && chmod +x xv6/*.pl \
    \
    # cleanup to reduce image size
    && apt-get purge -qq git \
    && apt-get autoremove --purge -qq \
    && apt-get clean -qq \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/* \
    && rm -rf /usr/share/man/* /usr/share/doc/*

WORKDIR /xv6

CMD ["/bin/bash"]
