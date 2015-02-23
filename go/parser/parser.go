package parser

// Shunting yard time!

import (
	"../lexer"
	"strconv"
)

var PRECEDENCE = map[string]int{
	"^": 4,
	"*": 3,
	"/": 3,
	"+": 2,
	"-": 2,
}

type Operator struct {
	Kind  string
	Value string
}

type Number struct {
	Kind  string
	Value float64
}

type Parser struct {
	Tokens    []lexer.Token
	Operators []string
	Output    []interface{}
}

func (parser *Parser) Parse() {
	for _, token := range parser.Tokens {
		if token.Kind == "NUMBER" {
			parsedNumber, _ := strconv.ParseFloat(token.Value, 64)
			parsedToken := Number{
				Kind:  token.Kind,
				Value: parsedNumber,
			}
			parser.Output = append(parser.Output, parsedToken)
		} else if token.Kind == "OPERATOR" {
			parsedToken := Operator{
				Kind:  token.Kind,
				Value: token.Value,
			}
			parser.Output = append(parser.Output, parsedToken)
		}
	}
}
