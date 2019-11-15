package hello

import (
	"testing"
)

/*
 * The unit tests in this file simulate command line invocation.
 */

func TestHello(test *testing.T) {
	//	want := "Hello, world! from unknown version 0.0.0-0\n"
	want := "Hello, world."
	if got := Hello(); got != want {
		test.Errorf("Hello() = %q, want %q", got, want)
	}
}
