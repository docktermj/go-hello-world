ARG IMAGE_FPM_BUILDER=alpine:3.12


# -----------------------------------------------------------------------------
# Stage: go_builder
# -----------------------------------------------------------------------------

ARG IMAGE_GO_BUILDER=golang:1.17.1
FROM ${IMAGE_GO_BUILDER} as go_builder
ENV REFRESHED_AT 2021-09-20
LABEL Name="docktermj/hello-world-go-builder" \
      Maintainer="nemo@dockter.com" \
      Version="1.0.0"

# Build arguments.

ARG PROGRAM_NAME="unknown"
ARG BUILD_VERSION=0.0.0
ARG BUILD_ITERATION=0
ARG HELLO_NAME="world"
ARG GO_PACKAGE_NAME="unknown"

# Copy local files from the Git repository.

COPY . ${GOPATH}/src/${GO_PACKAGE_NAME}

# Build go program.

WORKDIR ${GOPATH}/src/${GO_PACKAGE_NAME}
RUN make build

# --- Test go program ---------------------------------------------------------

# Run unit tests.

# RUN go get github.com/jstemmer/go-junit-report \
#  && mkdir -p /output/go-junit-report \
#  && go test -v ${GO_PACKAGE_NAME}/... | go-junit-report > /output/go-junit-report/test-report.xml

# Copy binaries to /output.

RUN mkdir -p /output \
 && cp -R ${GOPATH}/src/${GO_PACKAGE_NAME}/target/*  /output/

# -----------------------------------------------------------------------------
# Stage: fpm_builder
# -----------------------------------------------------------------------------

# Reference: https://github.com/jordansissel/fpm/blob/master/Dockerfile

FROM ${IMAGE_FPM_BUILDER} as fpm_builder
ENV REFRESHED_AT 2021-09-20
LABEL Name="docktermj/hello-world-fpm-builder" \
      Maintainer="nemo@dockter.com" \
      Version="1.0.0"

# Install FPM.

RUN apk add --no-cache \
      ruby \
      ruby-dev \
      ruby-etc \
      gcc \
      libffi-dev \
      make \
      libc-dev \
      rpm \
 && gem install --no-document fpm

# Copy files from prior step.

COPY --from=go_builder "/output/* "/output"

# Create RPM package.

RUN fpm \
  --input-type dir \
  --output-type rpm \
  --name ${PROGRAM_NAME} \
  --package /output/linux \
  --version ${BUILD_VERSION} \
  --iteration ${BUILD_ITERATION} \
  /root/go/bin/=/usr/bin

# Create DEB package.

RUN fpm \
  --input-type dir \
  --output-type deb \
  --name ${PROGRAM_NAME} \
  --package /output/linux \
  --version ${BUILD_VERSION} \
  --iteration ${BUILD_ITERATION} \
  /root/go/bin/=/usr/bin

# -----------------------------------------------------------------------------
# Stage: final
# -----------------------------------------------------------------------------

ARG IMAGE_FINAL=alpine
FROM ${IMAGE_FINAL} as final
ENV REFRESHED_AT 2021-09-20
LABEL Name="docktermj/hello-world" \
      Maintainer="nemo@dockter.com" \
      Version="1.0.0"

# Copy files from prior step.

COPY --from=fpm_builder "/output/*" "/output"

CMD ["/bin/bash"]
