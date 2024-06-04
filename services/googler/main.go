package main

import (
	"fmt"
	"log"
	"os/exec"
)

var modes = []string{"off", "low", "medium", "high"}

func main() {
	backlightDir := "/sys/class/leds/asus::kbd_backlight/brightness"

	out, err := exec.Command(fmt.Sprintf("echo 1 > %s", backlightDir)).Output()
	if err != nil {
		log.Fatal(err)
	}

	fmt.Printf("Changed backlight brightness to %s\n", modes[1])
}
