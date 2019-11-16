package hello

import (
	"fmt"
)

// Values updated via "go install -ldflags" parameters.

var programName string = "unknown"
var buildVersion string = "0.0.0"
var buildIteration string = "0"

func Hello() string {
	return fmt.Sprintf("Hello, world! from %s version %s-%s\n", programName, buildVersion, buildIteration)
}
