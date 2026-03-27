#  Copyright (C) 2018 Curt Brune <curt@cumulusnetworks.com>
#
#  Modified with permission from Benayak Karki
#
#  SPDX-License-Identifier:     GPL-2.0

FROM debian:10

# Debian 10 (buster) is EOL -- redirect to archive mirror
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org|archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    sed -i '/buster-updates/d' /etc/apt/sources.list

# Add initial development packages
RUN apt-get update && apt-get install -y \
    build-essential stgit u-boot-tools util-linux \
    gperf device-tree-compiler python-all-dev python-dev python3-dev xorriso \
    autoconf automake bison flex texinfo libtool libtool-bin \
    gawk libncurses5 libncurses5-dev bc \
    dosfstools mtools pkg-config git wget help2man gettext autopoint libexpat1 \
    libexpat1-dev fakeroot python-sphinx rst2pdf \
    libelf-dev \
    gnupg2 \
    efitools \
    libefivar-dev libnss3-tools libnss3-dev libpopt-dev \
    libssl-dev sbsigntool uuid-runtime uuid-dev cpio \
    bsdmainutils curl sudo unzip unifdef rsync locales tree

# crosstool-NG gdb configure expects python-config
RUN if [ ! -x /usr/bin/python-config ] && [ -x /usr/bin/python2.7-config ]; then \
      ln -s /usr/bin/python2.7-config /usr/bin/python-config; \
    fi

# Generate en_US.UTF-8 locale (required by uClibc-ng build)
RUN sed -i 's/# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Create build user
RUN useradd -m -s /bin/bash build && \
        adduser build sudo && \
        echo "build:build" | chpasswd

WORKDIR /home/build

# Add /sbin and /usr/sbin to build user's path
RUN echo export PATH="/sbin:/usr/sbin:\$PATH" >> .bashrc

# Add common files, like .gitconfig
COPY home .

# Create /home/build/src as a mount point for sharing files with the
# host system.
RUN mkdir src

# Make sure everything in /home/build is owned by the build user
RUN chown -R build:build .

USER build

RUN git config --global --add safe.directory '*' && \
    git config --global user.name "ONIE Build" && \
    git config --global user.email "build@example.com"

CMD ["/bin/bash", "--login"]
