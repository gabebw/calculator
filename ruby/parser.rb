# Uses the shunting-yard algorithm to handle precedence and
# outputs reverse polish notation.
#
# https://en.wikipedia.org/wiki/Shunting-yard_algorithm
class Parser
  PRECEDENCE = {
    "+" => 2,
    "-" => 2,
    "*" => 3,
    "/" => 3,
  }

  def initialize(tokens)
    @tokens = tokens
    @operators = []
    @output = []
  end

  attr_reader :output

  def parse
    @tokens.each do |token|
      if token[0] == :NUMBER
        @output << token[1].to_i
      elsif token[0] == :OPERATOR
        o1 = token[1]
        o2 = @operators.last
        while o2 && PRECEDENCE[o1] < PRECEDENCE[o2]
          @output << @operators.pop
          o2 = @operators.last
        end

        @operators << o1
      end
    end

    # Add any remaining operators to the output stack
    @output += @operators.reverse
  end
end
