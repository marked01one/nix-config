package main

import (
	"fmt"
	"log"
	"os/exec"
	"strings"
)

func main() {

	out, err := exec.Command("sh", "-c", "git diff").Output()
	if err != nil {
		log.Fatal(err)
	}

	diffLines := strings.Split(string(out), "\n")

	defer func() {
		if err := recover(); err != nil {
			return
		}
	}()

	for _, line := range diffLines {

		if line[:3] == "+++" {
			fmt.Printf("\033[32m%s\033[0m\n", line)
		}
	}

}
