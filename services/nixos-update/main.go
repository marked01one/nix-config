package main

import (
	"fmt"
	"log"
	"os/exec"
	"strings"
)

func logError(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

func main() {
	pwd, err := exec.Command("sh", "-c", "git rev-parse --show-toplevel").Output()
	logError(err)
	out, err := exec.Command("sh", "-c", "git diff").Output()
	logError(err)

	diffLines := strings.Split(string(out), "\n")

	for _, line := range diffLines {
		if len(line) < 3 {
			break
		}
		if line[:3] == "+++" {
			fmt.Printf("\033[32m%s\033[0m\n", line)
			break
		}
	}
	out, err = exec.Command("echo", "Formatting Nix files...").Output()
	go exec.Command("sh", "-c", fmt.Sprintf("alejandra %s", pwd)).Run()
	fmt.Printf("%s\n", string(out))
	logError(err)
}
