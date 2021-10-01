# -----------------------------------------------------------------------------
# Stages
# -----------------------------------------------------------------------------

ARG IMAGE_GO_BUILDER=golang:1.17.1
ARG IMAGE_FPM_BUILDER=dockter/fpm:latest

# -----------------------------------------------------------------------------
# Stage: go_builder
# -----------------------------------------------------------------------------

FROM ${IMAGE_GO_BUILDER} as go_builder
ENV REFRESHED_AT 2021-09-20a
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

RUN cd /output \
 && ls -laR

# -----------------------------------------------------------------------------
# Stage: fpm_builder
# -----------------------------------------------------------------------------

# Reference: https://github.com/jordansissel/fpm/blob/master/Dockerfile

FROM ${IMAGE_FPM_BUILDER} as fpm_builder
ENV REFRESHED_AT 2021-09-20f
LABEL Name="docktermj/hello-world-fpm-builder" \
      Maintainer="nemo@dockter.com" \
      Version="1.0.0"

# Use arguments from prior stage.

ARG PROGRAM_NAME
ARG BUILD_VERSION
ARG BUILD_ITERATION
ARG HELLO_NAME
ARG GO_PACKAGE_NAME

# Copy files from prior stage.

COPY --from=go_builder "/output/darwin/go-hello-world"      "/input/darwin/go-hello-world"
COPY --from=go_builder "/output/linux/go-hello-world"       "/input/linux/go-hello-world"
COPY --from=go_builder "/output/windows/go-hello-world.exe" "/input/windows/go-hello-world.exe"

# FPM: https://fpm.readthedocs.io/en/latest/cli-reference.html

# Create RPM package.

RUN cd /input \
 && ls -laR

RUN mkdir /output

RUN echo "1) ${PROGRAM_NAME}" \
 && echo "2) ${BUILD_VERSION}" \
 && echo "3) ${BUILD_ITERATION}"

RUN fpm \
  --input-type dir \
  --output-type rpm \
  --name ${PROGRAM_NAME} \
  --package /output/${PROGRAM_NAME}-${BUILD_VERSION}.rpm \
  --version ${BUILD_VERSION} \
  --iteration ${BUILD_ITERATION} \
  /input/linux=/usr/bin

RUN cd /output \
 && ls -laR

# Create DEB package.

RUN fpm \
  --input-type dir \
  --output-type deb \
  --name ${PROGRAM_NAME} \
  --package /output/${PROGRAM_NAME}-${BUILD_VERSION}.deb \
  --version ${BUILD_VERSION} \
  --iteration ${BUILD_ITERATION} \
  /input/linux/=/usr/bin

RUN cd /output \
 && ls -laR

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

COPY --from=fpm_builder "/output/*" "/output/"

CMD ["/bin/bash"]
