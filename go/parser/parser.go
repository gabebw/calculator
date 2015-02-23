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
	Value string
}

type Number struct {
	Value float64
}

type Parser struct {
	Tokens    []lexer.Token
	Operators []string
	Output    []interface{}
}

func (parser *Parser) parse() {
	for _, token := range parser.Tokens {
		if token.Kind == "NUMBER" {
			parsedNumber, _ := strconv.ParseFloat(token.Value, 64)
			parsedToken := Number{
				Value: parsedNumber,
			}
			parser.Output = append(parser.Output, parsedToken)
		} else if token.Kind == "OPERATOR" {
			parsedToken := Operator{
				Value: token.Value,
			}
			parser.Output = append(parser.Output, parsedToken)
		}
	}
}
