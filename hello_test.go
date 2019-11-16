package hello

import (
	"strings"
	"testing"
)

/*
 * The unit tests in this file simulate command line invocation.
 */

func TestHello(testing *testing.T) {
	want := "Hello, world! from unknown version"
	if got := Hello(); !strings.HasPrefix(got, want) {
		testing.Errorf("Hello() = %q, want %q", got, want)
	}
}
