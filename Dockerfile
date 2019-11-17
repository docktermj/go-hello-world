FROM centos:7.7.1908

ENV REFRESHED_AT 2019-11-16

# --- Install system packages -------------------------------------------------

# Avoid "Error: libselinux conflicts with fakesystemd-1-17.el7.centos.noarch"

RUN yum -y swap fakesystemd systemd \
 && yum -y install systemd-devel \
 && yum clean all

RUN yum -y update

# Install [base, ruby] dependencies.

RUN yum -y install \
    git \
    tar \
    wget \
 && yum -y install \
    gcc \
    make \
    rpm-build \
    ruby-devel \
    rubygems \
    which

# Install Effing Package Manager (FPM).

RUN gem install --no-ri --no-rdoc fpm

# --- Install Go --------------------------------------------------------------

ENV GO_VERSION=1.13.4

RUN wget https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz \
 && tar -C /usr/local/ -xzf go${GO_VERSION}.linux-amd64.tar.gz

# --- Compile go program ------------------------------------------------------

ARG PROGRAM_NAME="unknown"
ARG BUILD_VERSION=0.0.0
ARG BUILD_ITERATION=0
ARG HELLO_NAME="Bob"

ENV HOME="/root"
ENV GOPATH="${HOME}/go"
ENV PATH="${PATH}:/usr/local/go/bin:${GOPATH}/bin"
ENV GO_PACKAGE="github.com/docktermj/${PROGRAM_NAME}"

# Copy local files from the Git repository.

COPY . ${GOPATH}/src/${GO_PACKAGE}

# Build go program.

WORKDIR ${GOPATH}/src/${GO_PACKAGE}

RUN mkdir ~/.ssh \
 && touch ~/.ssh/known_hosts \
 && ssh-keyscan github.com >> ~/.ssh/known_hosts \
 && go get -u ./... \
 && go install \
    -ldflags  \
      "-X main.programName=${PROGRAM_NAME} \
       -X main.buildVersion=${BUILD_VERSION} \
       -X main.buildIteration=${BUILD_ITERATION} \
       -X github.com/docktermj/go-hello-world-module.helloName=${HELLO_NAME} \
      " \
    ${GO_PACKAGE}

# Copy binary to output.

RUN mkdir -p /output/bin \
 && cp /root/go/bin/${PROGRAM_NAME} /output/bin

# --- Test go program ---------------------------------------------------------

# Run unit tests.

# RUN go get github.com/jstemmer/go-junit-report \
#  && mkdir -p /output/go-junit-report \
#  && go test -v ${GO_PACKAGE}/... | go-junit-report > /output/go-junit-report/test-report.xml

# --- Package as RPM and DEB --------------------------------------------------

WORKDIR /output

# RPM package.

RUN fpm \
  --input-type dir \
  --output-type rpm \
  --name ${PROGRAM_NAME} \
  --version ${BUILD_VERSION} \
  --iteration ${BUILD_ITERATION} \
  /root/go/bin/=/usr/bin

# DEB package.

RUN fpm \
  --input-type dir \
  --output-type deb \
  --name ${PROGRAM_NAME} \
  --version ${BUILD_VERSION} \
  --iteration ${BUILD_ITERATION} \
  /root/go/bin/=/usr/bin

# --- Epilog ------------------------------------------------------------------

RUN yum clean all

CMD ["/bin/bash"]
