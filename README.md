# go-hello-world

Build `go-hello-world-M.m.P-I.x86_64.rpm`.
Where "M.m.P-I" is Major.minor.Patch-Iteration.

## Build

```console
sudo make compile
```

The results will be in the `.../target` directory.

## Install

### RPM-based

openSUSE, Fedora, CentOS, Mandrake

#### RPM Install

Example:

```console
sudo rpm -ivh go-hello-world-M.m.P-I.x86_64.rpm
```

#### RPM Update

Example: 

```console
sudo rpm -Uvh go-hello-world-M.m.P-I.x86_64.rpm
```

### Debian

Ubuntu

#### Debian Install / Update

Example:

```console
sudo dpkg-i go-hello-world_M.m.P-I_amd64.deb
```

## Cleanup

```console
sudo make clean
```
