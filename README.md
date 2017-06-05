# go-hello-world

Build `go-hello-world-M.m.P-I.x86_64.rpm`
and   `go-hello-world_M.m.P-I_amd64.deb`
where "M.m.P-I" is Major.minor.Patch-Iteration.

## Usage

A simple "hello world" program.
The purpose of the repository it to show how to:

1. Build go executable locally
1. Build go executable via Docker
1. Build RPM / DEB installation via Docker.

### Invocation

```console
go-hello-world
```

## Development

### Dependencies

#### Set environment variables

```console
export GOPATH="${HOME}/gocode"
export PATH="${PATH}:/usr/local/go/bin:${GOPATH}/bin"
export PROJECT_DIR=${GOPATH}/src/github.com/docktermj
```

#### Download project

```console
mkdir -p ${PROJECT_DIR}
cd ${PROJECT_DIR}
git clone git@github.com:docktermj/go-hello-world.git
```

#### Download dependencies

```console
go get github.com/docopt/docopt-go
```

### Build

#### Local build

```console
go install github.com/docktermj/go-hello-world
```

The results will be in the `${GOPATH}/bin` directory.

#### Docker build

```console
cd ${PROJECT_DIR}/go-hello-world
sudo make compile
```

The results will be in the `.../target` directory.

### Install

#### RPM-based

openSUSE, Fedora, CentOS, Mandrake

##### RPM Install

Example:

```console
sudo rpm -ivh go-hello-world-M.m.P-I.x86_64.rpm
```

##### RPM Update

Example: 

```console
sudo rpm -Uvh go-hello-world-M.m.P-I.x86_64.rpm
```

#### Debian

Ubuntu

##### Debian Install / Update

Example:

```console
sudo dpkg-i go-hello-world_M.m.P-I_amd64.deb
```

### Cleanup

```console
sudo make clean
```
