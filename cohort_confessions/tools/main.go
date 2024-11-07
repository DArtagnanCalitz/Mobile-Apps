package main

import (
	"bufio"
	"flag"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

// Run this program by running:
// `go run ./tools -i ./input.html -o ../out.csv -f`
func main() {
	// Command Line Interface parameters
	inputLocation := flag.String("i", "", "location of source file")
	outputLocation := flag.String("o", "", "location of output file")
	forceWrite := flag.Bool("f", false, "force overwrite csv file")
	skipFirstName := flag.Bool("n1", false, "do not include first name")
	skipLastName := flag.Bool("n2", false, "do not include last name")
	flag.Parse()

	// Print all Command Line Interface parameters
	fmt.Println("CSV Location: " + *inputLocation)
	fmt.Println("CSV Location: " + *outputLocation)
	fmt.Println("Force Write: " + strconv.FormatBool(*forceWrite))
	fmt.Println("Skip First Name: " + strconv.FormatBool(*skipFirstName))
	fmt.Println("Skip Last Name: " + strconv.FormatBool(*skipLastName))

	fmt.Println()
	fmt.Println("STARTING PROCESS")

	fmt.Println("CHECKING INPUT FILE EXISTS")

	_, err := os.Stat(*inputLocation)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	var fileFlags int

	if *forceWrite {
		fmt.Println("OVERWRITING OUTPUT FILE ENABLED")
		fileFlags = os.O_CREATE | os.O_RDWR

	} else {
		fmt.Println("OVERWRITING OUTPUT FILE DISABLED")
		fileFlags = os.O_CREATE | os.O_EXCL
	}

	fmt.Println("OPENING INPUT FILE")

	input, err := os.Open(*inputLocation)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	defer input.Close()

	fmt.Println("OPENING OUTPUT FILE")

	output, err := os.OpenFile(*outputLocation, fileFlags, os.ModePerm)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	defer output.Close()

	// ADD DATA HERE

	// Search each line for <span class="mobile-table-label">First Name: </span>
	// Next line
	// Remove all white spaces
	// Remove prefix <span class="table-data-cell-value">
	// Remove suffix </span></td>
	// Store value in memory
	// Once all data is done, write to file
	// Repeat until end of file

	namePrompt := `<h1 class="name-information-profile-card"`
	// namePrompt := `<span class="mobile-table-label">First Name: </span>`
	// emailPrompt := `<span class="mobile-table-label">Email: </span>`

	scanner := bufio.NewScanner(input)

	nameBuf := "nil"
	// emailBuf = "nilEmail"

	for scanner.Scan() {
		buf := scanner.Text()

		if !strings.Contains(buf, namePrompt) {
			continue
		}
		stringBuf := scanner.Text()
		stringBuf = strings.TrimSpace(stringBuf)

		// find first > character
		beginChar := strings.Index(stringBuf, ">")
		if beginChar <= -1 {
			fmt.Println("First index not found... Next")
			continue
		}

		stringBuf = stringBuf[beginChar+1:]

		// find first < character
		endChar := strings.Index(stringBuf, "<")
		if beginChar <= -1 {
			fmt.Println("Last index not found... Next")
			continue
		}

		nameBuf = stringBuf[:endChar]

		_, err := fmt.Fprintln(output, nameBuf)
		if err != nil {
			fmt.Println(err)
			os.Exit(1)
		}
	}

	fmt.Println("FINISHED PARSING FILE")

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

	fmt.Println("ENDING PROGRAM")
}
