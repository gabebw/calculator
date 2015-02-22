require "./lexer"
require "./parser"

lexer = Lexer.new("1 + 200 * 3 / 4")
lexer.tokenize

parser = Parser.new(lexer.tokens)
parser.parse

p parser.output

result = parser.output == [1, 200, 3, 4, "/", "*", "+"]
if result
  puts "It works!"
else
  puts "It doesn't work :("
end
