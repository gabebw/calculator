require "./lexer"
require "./parser"
require "./interpreter"

expression = "1+ 200*3/4 - 51"
expected_result = 100

lexer = Lexer.new(expression)
lexer.tokenize

parser = Parser.new(lexer.tokens)
parser.parse

interpreter = Interpreter.new(parser.output)
result = interpreter.run

if result == expected_result
  puts "It works!"
else
  puts "It doesn't work :("
  p parser.output
end
