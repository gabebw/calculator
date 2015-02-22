require "./lexer"
require "./parser"
require "./interpreter"

expected_parser_output = [
  [:NUMBER, 1],
  [:NUMBER, 200],
  [:NUMBER, 3],
  [:NUMBER, 4],
  [:OPERATOR, "/"],
  [:OPERATOR, "*"],
  [:OPERATOR, "+"],
]

lexer = Lexer.new("1 + 200 * 3 / 4")
lexer.tokenize

parser = Parser.new(lexer.tokens)
parser.parse

interpreter = Interpreter.new(parser.output)
result = interpreter.run

if result == 201
  puts "It works!"
else
  puts "It doesn't work :("
  p parser.output
end
