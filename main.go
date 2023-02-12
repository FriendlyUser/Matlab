package main

import (
	"fmt"
	"io"
	"strings"

	"github.com/bitfield/script"
)

// basic go cli tool
func main() {
	// go through each directory in go using os package
	htmlFiles := []string{}
	outputFolder := "gh-pages"
	reg := []string{"rm", "-rf", outputFolder}
	cmd := strings.Join(reg[:], " ")

	tmpl := `
	<html>
		<head>
			<title>List of Files</title>
		</head>
		<body>
			<h1>List of Files</h1>
			<ul>
			{{ range . }}
				<li>{{ . }}</li>
			{{ end }}
			</ul>
		</body>
	</html>
	`
	script.IfExists(outputFolder).Exec(cmd).Stdout()
	script.FindFiles(".").FilterScan(func(line string, w io.Writer) {
		// if line contains html print it
		if strings.Contains(line, ".html") || strings.Contains(line, ".pdf") {
			fmt.Fprintf(w, "scanned line: %q\n", line)
			htmlFiles = append(htmlFiles, line)
		}
	}).Stdout()

	fmt.Println(htmlFiles)
	// create html directory
	script.Exec("mkdir " + outputFolder).Stdout()

	// for each html file
	for _, file := range htmlFiles {
		reg = []string{"cp", file, outputFolder}
		cmd = strings.Join(reg[:], " ")
		// copy file to html directory
		script.Exec(cmd).Stdout()
	}
}
