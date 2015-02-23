package lexer

import (
	"regexp"
)

type Token struct {
	Kind  string
	Value string
}

func isInArray(a string, list []string) bool {
	for _, b := range list {
		if b == a {
			return true
		}
	}
	return false
}

func isOperator(op string) bool {
	operators := []string{"+", "*", "-", "/", "^"}
	return isInArray(op, operators)
}

func Lex(expression string) []Token {
	spaces := regexp.MustCompile("\\s+")
	tokens := make([]Token, 0)
	split := spaces.Split(expression, -1)

	for _, chunk := range split {
		matchedNumber, _ := regexp.MatchString("\\A[0-9\\.]+", chunk)
		if matchedNumber {
			token := Token{
				Kind:  "NUMBER",
				Value: chunk,
			}
			tokens = append(tokens, token)
		} else if isOperator(chunk) {
			token := Token{
				Kind:  "OPERATOR",
				Value: chunk,
			}
			tokens = append(tokens, token)
		}
	}

	return tokens
}
