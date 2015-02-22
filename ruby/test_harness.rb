require "./lexer"
require "./parser"
require "./interpreter"


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
