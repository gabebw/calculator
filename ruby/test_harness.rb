require "pp"

require "./lexer"
require "./parser"
require "./interpreter"

expression = "1+ 200/100*3 - 3.5 + -3.5"
expected_result = 0

lexer = Lexer.new(expression)
lexer.tokenize

parser = Parser.new(lexer.tokens)
parser.parse

interpreter = Interpreter.new(parser.output)
result = interpreter.run

if result == expected_result
  puts "It works!"
else
  puts "!! It doesn't work. Got #{result}, expected #{expected_result}"

  pp lexer.tokens
  puts
  pp parser.output
end
