package main

import (
	"./lexer"
)
func main() {
	expression := "1 + 2.3 * 4 - 2 ^ 5"
	lexer.Lex(expression)
}
