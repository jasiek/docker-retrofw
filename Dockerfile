FROM ubuntu:latest AS base
RUN apt-get update
RUN apt-get install -y build-essential libncurses5 libncurses5-dev git python unzip bc wget
RUN apt-get install -y rsync cpio

FROM base AS builder
WORKDIR /opt
RUN wget https://buildroot.org/downloads/buildroot-2018.02.9.tar.gz
RUN tar -xzvf buildroot-2018.02.9.tar.gz
WORKDIR /opt/buildroot-2018.02.9
COPY config ./.config
ENV FORCE_UNSAFE_CONFIGURE 1
RUN make

FROM base AS dist
RUN mkdir -p /opt/rs97tools/
RUN mkdir -p /opt/rs97apps/
COPY --from=builder /opt/buildroot-2018.02.9/output/host/* /opt/rs97tools/
ENV PATH /opt/rs97tools/mipsel-buildroot-linux-uclibc/sysroot/usr/bin:$PATH
ENV PATH /opt/rs97tools/bin:$PATH
WORKDIR /opt/rs97apps/
