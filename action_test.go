package unittestsaction

import "testing"

func TestPrintsHelloWorld(t *testing.T) {
	if !printHelloWorld() {
		t.Fail()
	}
}
