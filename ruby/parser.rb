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
    "^" => 4,
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
        @output << [token[0], token[1].to_f]
      elsif token[0] == :OPERATOR
        o1 = token[1]
        if @operators.size > 0
          o2 = @operators.last[1]
          while o2 && PRECEDENCE[o1] <= PRECEDENCE[o2]
            @output << @operators.pop
            if @operators.length > 0
              o2 = @operators.last[1]
            else
              o2 = nil
            end
          end
        end

        @operators << token
      end
    end

    # Add any remaining operators to the output stack
    @output += @operators.reverse
  end
end
