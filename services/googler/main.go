package main

import (
	"fmt"
	"log"
	"os/exec"
	"strconv"
)

var modes = []string{"off", "low", "medium", "high"}

func logError(err error) {
	if err != nil {
		log.Fatal(err)
	}
	return
}

func main() {
	backlightDir := "/sys/class/leds/asus::kbd_backlight/brightness"

	currBright, err := exec.Command("sh", "-c", fmt.Sprintf("cat %s", backlightDir)).Output()
	logError(err)

	currValue, err := strconv.ParseInt(string(currBright[:1]), 10, 32)
	logError(err)

	var nextValue int64 = 0

	if currValue < 3 {
		nextValue = currValue + 1
	}

	_, err = exec.Command("sh", "-c", fmt.Sprintf("echo %d > %s", nextValue, backlightDir)).Output()
	logError(err)

	fmt.Printf("Changed backlight brightness to %s\n", modes[nextValue])
}
