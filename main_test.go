package main

import (
	"testing"
	"os"
)

/*
 * The unit tests in this file simulate command line invocation.
 */

func TestMain(test *testing.T) {
	os.Args = []string{programName}
	main()
}
