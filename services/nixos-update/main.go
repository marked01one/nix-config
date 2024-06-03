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

func nixFormat(nixRoot string) {
	_, err := exec.Command("echo", "Formatting Nix files...").Output()
	logError(err)
	out, err := exec.Command("sh", "-c", fmt.Sprintf("alejandra %s", nixRoot)).Output()
	fmt.Printf("%s\n", string(out))
	logError(err)
}

func gitDiff() {

	out, err := exec.Command("sh", "-c", "git diff").Output()
	logError(err)

	diffLines := strings.Split(string(out), "\n")

	fmt.Println("\nADDED CHANGES:")
	for _, line := range diffLines {
		if len(line) < 3 {
			continue
		}
		if line[:3] == "+++" {
			fmt.Printf("\033[32m%s\033[0m\n", line)
			continue
		}
	}

	fmt.Println("\nREMOVED CHANGES:")
	for _, line := range diffLines {
		if len(line) < 3 {
			continue
		}
		if line[:3] == "---" {
			fmt.Printf("\033[31m%s\033[0m\n", line)
			continue
		}
	}
}

func main() {
	gitDiff()
	nixRoot, err := exec.Command("sh", "-c", "git rev-parse --show-toplevel").Output()
	logError(err)
	nixFormat(string(nixRoot))
}
