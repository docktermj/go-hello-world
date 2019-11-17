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

## Development


## Create package

### Prerequisite software

The following software programs need to be installed:

1. [git](https://github.com/docktermj/KnowledgeBase/blob/master/software/git.md#installation)
1. [docker](https://github.com/docktermj/KnowledgeBase/blob/master/software/docker.md#installation)

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

### Build RPM and DEB files

1. Use make target to run a docker images that builds RPM and DEB files.
   Example:

    ```console
    cd ${GIT_REPOSITORY_DIR}
    make build
    ```

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






------------------------------------------

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



## References

1. [Using Go Modules](https://blog.golang.org/using-go-modules)
1. [Simple Go project layout with modules ](https://eli.thegreenplace.net/2019/simple-go-project-layout-with-modules/)
1. [Project layout](https://github.com/golang-standards/project-layout)
