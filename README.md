# go-hello-world

Build `go-hello-world-M.m.P-I.x86_64.rpm`
and   `go-hello-world_M.m.P-I_amd64.deb`
where "M.m.P-I" is Major.minor.Patch-Iteration.

## Usage

A simple "hello world" program.
The purpose of the repository is to show how to:

1. Build go executable locally
1. Build go executable via Docker
1. Build RPM / DEB installation via Docker.

### Invocation

1. Run on commandline. Example:

    ```console
    go-hello-world
    ```

## Development

### Dependencies

#### Set environment variables

1. :pencil2: Set Go environment variables.
   Example:

    ```console
    export GOPATH="${HOME}/go"
    export PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"
    ```

1. :pencil2: Set Git Repository variables.
   Example:

    ```console
    export GIT_ACCOUNT=docktermj
    export GIT_REPOSITORY=go-hello-world
    ```

1. Set filesystem variables.
   Example:

    ```console
    export GIT_PROJECT_DIR="${GOPATH}/src/github.com/${GIT_ACCOUNT}"
    export GIT_REPOSITORY_DIR="${GIT_PROJECT_DIR}/${GIT_REPOSITORY}"
    ```

#### Download project

1. Option #1. Download via `git`.
   Example:

    ```console
    mkdir -p ${GIT_PROJECT_DIR}
    cd ${GIT_PROJECT_DIR}
    git clone git@github.com:docktermj/go-hello-world.git
    ```

1. Option #2. Download via `go`.   This is like `git clone https://...`
   Example:

    ```console
    go get github.com/${GIT_ACCOUNT}/${GIT_REPOSITORY}
    ```

#### Download dependencies

1. XXX.
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}
    make dependencies
    ```

### Build

#### Local build

1. XXX
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}
    make build-local
    ```

   The results will be in the `${GOPATH}/bin` directory.

#### Docker build

1. XXX
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}
    make build
    ```

   The results will be in the `.../target` directory.

### Test

1. XXX
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}
    make test-local
    ```

### Install

#### RPM-based

Example distributions: openSUSE, Fedora, CentOS, Mandrake

##### RPM Install

1. XXX
   Example:

    ```console
    sudo rpm -ivh go-hello-world-M.m.P-I.x86_64.rpm
    ```

##### RPM Update

1. XXX
   Example:

    ```console
    sudo rpm -Uvh go-hello-world-M.m.P-I.x86_64.rpm
    ```

#### Debian

1. Example distributions: Ubuntu

##### Debian Install / Update

1. XXX
   Example:

    ```console
    sudo dpkg -i go-hello-world_M.m.P-I_amd64.deb
    ```

### Cleanup

1. XXX
   Example:

    ```console
    cd ${REPOSITORY_DIR}
    make clean
    ```
