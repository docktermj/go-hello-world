# go-hello-world

Build `go-hello-world-M.m.P-I.x86_64.rpm`.
Where "M.m.P-I" is Major.minor.Patch-Iteration.

## Build

```console
sudo make compile
```

The results will be in the {{.../target}} directory.

## Install 

### Initial installation

Example:

```console
sudo rpm -ivh go-hello-world-M.m.P-I.x86_64.rpm
```

### Update

Example: 

```console
sudo rpm -Uvh go-hello-world-M.m.P-I.x86_64.rpm
```

## Cleanup

```console
sudo make clean
```
