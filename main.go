package main

import "fmt"

var gitVersion string = "0.0.0"
var gitIteration string = "0"

func main() {
    fmt.Printf("Hello, world! from Version %s-%s\n", gitVersion, gitIteration)
}