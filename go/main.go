package main

import (
	"./lexer"
	"./parser"
	"fmt"
)

func main() {
	expression := "1 + 2.3 * 4 - 2 ^ 5"
	tokens := lexer.Lex(expression)

	myParser := parser.Parser{
		Tokens: tokens,
	}
	myParser.Parse()

	// fmt.Println(tokens)
	fmt.Println(myParser.Output)
}
