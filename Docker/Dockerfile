FROM debian:stable-slim

ENV INSTALL_DIR=/chia
ENV BRANCH=main
ENV CHIA_INDEX=https://pypi.chia.net/simple/

WORKDIR ${INSTALL_DIR}

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install --no-install-recommends -y \
    git \
    python3 \
    python3-pip \
    python3-venv

RUN git clone https://github.com/watercompany/chia-blockchain.git . && \
    git checkout ${BRANCH} && \
    git submodule update --init mozilla-ca

RUN python3 -m venv venv
ENV PATH="/${INSTALL_DIR}/venv/bin:${PATH}"

RUN pip install --upgrade pip
RUN pip install wheel
RUN pip install --extra-index-url ${CHIA_INDEX} miniupnpc==2.1
RUN pip install -e . --extra-index-url ${CHIA_INDEX}
