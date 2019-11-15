package hello

import (
	//	"fmt"
	//	"rsc.io/quote"
	"rsc.io/quote/v3"
)

// Values updated via "go install -ldflags" parameters.

var programName string = "unknown"
var buildVersion string = "0.0.0"
var buildIteration string = "0"

func Hello() string {
	//	return fmt.Sprintf("Hello, world! from %s version %s-%s\n", programName, buildVersion, buildIteration)
	return quote.HelloV3()
}

func Proverb() string {
	return quote.Concurrency()
}
