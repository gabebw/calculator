package main

import (
	"./interpreter"
	"./lexer"
	"./parser"
	"fmt"
)

func main() {
	expression := "1 + 2.3 * 4 - 2 ^ 5"

	tokens := lexer.Lex(expression)

	myParser := parser.NewParser(tokens)
	myParser.Parse()

	myInterpreter := interpreter.NewInterpreter(myParser.Output)

	result := myInterpreter.Run()
	if result == -21.8 {
		fmt.Println("It worked!")
	} else {
		fmt.Printf("myParser.Output: %v\n", myParser.Output)
		fmt.Printf("Result: %v\n", result)
	}
}
