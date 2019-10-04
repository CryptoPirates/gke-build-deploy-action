package unittestsaction

import (
	"fmt"

	"github.com/cryptopirates/gotalib"
)

func printHelloWorld() bool {
	fmt.Println("Hello, World!")
	gotalib.Ema([]float64{1.0, 2.0, 3.0}, 3)
	return true
}
