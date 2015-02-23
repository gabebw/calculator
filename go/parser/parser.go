package parser

// Shunting yard time!

import (
	"../lexer"
)

var PRECEDENCE = map[string]int{
	"^": 4,
	"*": 3,
	"/": 3,
	"+": 2,
	"-": 2,
}

type Node interface {
	NodeKind() string
	NodeValue() string
}

type Operator struct {
	Kind  string
	Value string
}

func (operator Operator) NodeKind() string {
	return operator.Kind
}

func (operator Operator) NodeValue() string {
	return operator.Value
}

type Number struct {
	Kind  string
	Value string
}

func (number Number) NodeKind() string {
	return number.Kind
}

func (number Number) NodeValue() string {
	return number.Value
}

type Parser struct {
	Tokens    []lexer.Token
	Operators []Operator
	Output    []Node
}

// Pop an operator. Cute.
func poperator(parser *Parser) Operator {
	length := len(parser.Operators)
	operator := parser.Operators[length-1]
	parser.Operators = parser.Operators[:length-1]
	return operator
}

func NewParser(tokens []lexer.Token) Parser {
	parser := Parser{
		Tokens:    tokens,
		Operators: make([]Operator, 0),
		Output:    make([]Node, 0),
	}
	return parser
}

func (parser *Parser) Parse() {
	for _, token := range parser.Tokens {
		if token.Kind == "NUMBER" {
			parsedToken := Number{
				Kind:  token.Kind,
				Value: token.Value,
			}
			parser.Output = append(parser.Output, parsedToken)
		} else if token.Kind == "OPERATOR" {
			operator := Operator{
				Kind:  token.Kind,
				Value: token.Value,
			}
			o1 := operator.Value
			if len(parser.Operators) > 0 {
				o2 := parser.Operators[len(parser.Operators)-1].Value
				for PRECEDENCE[o1] <= PRECEDENCE[o2] {
					lastOperator := poperator(parser)
					parser.Output = append(parser.Output, Node(lastOperator))
					if len(parser.Operators) > 0 {
						o2 = parser.Operators[len(parser.Operators)-1].Value
					} else {
						break
					}
				}
			}
			parser.Operators = append(parser.Operators, operator)
		}
	}

	// Add any remaining operators to the output stack
	for i := len(parser.Operators) - 1; i >= 0; i-- {
		parser.Output = append(parser.Output, Node(parser.Operators[i]))
	}
}
