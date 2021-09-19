package main

import (
	"fmt"

	hello "github.com/docktermj/go-hello-world-module"
)

// Values updated via "go install -ldflags" parameters.

var programName string = "unknown"
var buildVersion string = "0.0.0"
var buildIteration string = "0"

func main() {
	fmt.Println(hello.Hello())
	fmt.Printf("Hello, world! from %s (main) version %s-%s\n", programName, buildVersion, buildIteration)
}
