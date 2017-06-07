package main

import "fmt"

var buildVersion string = "0.0.0"
var buildIteration string = "0"

func main() {
    fmt.Printf("Hello, world! from Version %s-%s\n", buildVersion, buildIteration)
}