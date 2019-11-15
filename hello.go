package hello

import (
	//	"fmt"
	"rsc.io/quote"
	quoteV3 "rsc.io/quote/v3"
)

// Values updated via "go install -ldflags" parameters.

var programName string = "unknown"
var buildVersion string = "0.0.0"
var buildIteration string = "0"

func Hello() string {
	//	return fmt.Sprintf("Hello, world! from %s version %s-%s\n", programName, buildVersion, buildIteration)
	return quote.Hello()
}

func Proverb() string {
	return quoteV3.Concurrency()
}
