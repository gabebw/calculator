package interpreter

import (
	"../parser"
	"math"
	"strconv"
)

type Interpreter struct {
	Rpn   []parser.Node
	Stack []float64
}

func popNumberFromStack(interpreter *Interpreter) float64 {
	length := len(interpreter.Stack)
	number := interpreter.Stack[length-1]
	interpreter.Stack = interpreter.Stack[:length-1]
	return number
}

func NewInterpreter(nodes []parser.Node) Interpreter {
	return Interpreter{
		Rpn:   nodes,
		Stack: make([]float64, 0),
	}
}

func (interpreter *Interpreter) Run() float64 {
	for _, parsedToken := range interpreter.Rpn {
		switch parsedToken.(type) {
		case parser.Number:
			parsedNumber, _ := strconv.ParseFloat(parsedToken.NodeValue(), 64)
			interpreter.Stack = append(interpreter.Stack, parsedNumber)
		case parser.Operator:
			operator := parsedToken.NodeValue()
			number2 := popNumberFromStack(interpreter)
			number1 := popNumberFromStack(interpreter)
			result := apply(operator, number1, number2)
			interpreter.Stack = append(interpreter.Stack, result)
		}
	}

	result := interpreter.Stack[0]
	return result
}

func apply(operator string, number1 float64, number2 float64) float64 {
	switch operator {
	case "/":
		return number1 / number2
	case "*":
		return number1 * number2
	case "+":
		return number1 + number2
	case "-":
		return number1 - number2
	case "^":
		return math.Pow(number1, number2)
	}
	// fallback that should not be hit
	return 0
}
