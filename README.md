# go-hello-world

Build `go-hello-world-M.m.P-I.x86_64.rpm`
and   `go-hello-world_M.m.P-I_amd64.deb`
where "M.m.P-I" is Major.minor.Patch-Iteration.

## Usage

A simple "hello world" program.
The purpose of the repository is to show how to:

1. Use go modules
1. Build go executable locally
1. Build go executable via Docker
1. Build RPM / DEB installation via Docker.

### Invocation

1. Run on commandline. Example:

    ```console
    go-hello-world
    ```

## Prerequisites

### Prerequisite software

The following software programs need to be installed:

1. [git](https://github.com/docktermj/KnowledgeBase/blob/master/software/git.md#installation)
1. [docker](https://github.com/docktermj/KnowledgeBase/blob/master/software/docker.md#installation)
1. [go](https://github.com/docktermj/KnowledgeBase/blob/master/software/go.md#installation)

### Clone repository

1. Set these environment variable values:

    ```console
    export GIT_ACCOUNT=docktermj
    export GIT_REPOSITORY=go-hello-world
    export GIT_ACCOUNT_DIR=~/${GIT_ACCOUNT}.git
    export GIT_REPOSITORY_DIR="${GIT_ACCOUNT_DIR}/${GIT_REPOSITORY}"
    ```

1. Follow steps in [clone-repository](https://github.com/docktermj/KnowledgeBase/blob/master/HowTo/clone-repository.md)
   to install the Git repository.

### Set environment variables

1. :pencil2: Set Go environment variables.
   Example:

    ```console
    export GOPATH="${HOME}/go"
    export PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"
    ```

## Development

### Download dependencies

1. Dependencies.
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}
    make dependencies
    ```

### Build

1. Build.
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}
    make build-local
    ```

   The results will be in the `${GOPATH}/bin` directory.

### Test

1. Test
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}
    make test-local
    ```

### Cleanup

1. Delete.
   Example:

    ```console
    cd ${REPOSITORY_DIR}
    make clean
    ```

## Create package

### Build RPM and DEB files

1. Use make target to run a docker images that builds RPM and DEB files.
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}
    make build
    ```

   The results will be in the `.../target` directory.

## Test DEB package on Ubuntu

1. Determine if `go-hello-world` is installed.
   Example:

    ```console
    apt list --installed | grep go-hello-world
    ```

1. :pencil: Install `go-hello-world`.
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}/target
    sudo apt install ./go-hello-world_0.0.0_amd64.deb
    ```

1. Run command.
   Example:

    ```console
    go-hello-world
    ```

1. Remove `go-hello-world` from system.
   Example:

    ```console
    sudo apt-get remove go-hello-world
    ```

## Test RPM package on Centos

1. Determine if `go-hello-world` is installed.
   Example:

    ```console
    yum list installed | grep go-hello-world
    ```

1. :pencil: Install `go-hello-world`.
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}/target
    sudo yum install ./go-hello-world_0.0.0_amd64.rpm
    ```

1. Run command.
   Example:

    ```console
    go-hello-world
    ```

1. Remove `go-hello-world` from system.
   Example:

    ```console
    sudo yum remove go-hello-world
    ```

## References

1. [Using Go Modules](https://blog.golang.org/using-go-modules)
1. [Simple Go project layout with modules ](https://eli.thegreenplace.net/2019/simple-go-project-layout-with-modules/)
1. [Project layout](https://github.com/golang-standards/project-layout)
