package main

import (
	"./lexer"
	"./parser"
	"fmt"
)

func main() {
	expression := "1 + 2.3 * 4 - 2 ^ 5"
	tokens := lexer.Lex(expression)

	fmt.Println(tokens)
	p := parser.Parser{
		Tokens: tokens,
	}

	fmt.Println(p)
}
