class Interpreter
  def initialize(rpn)
    @rpn = rpn
    @stack = []
  end

  def run
    @rpn.each do |item|
      if item[0] == :NUMBER
        @stack << item[1]
      elsif item[0] == :OPERATOR
        operator = item[1]
        number1 = @stack.pop
        number2 = @stack.pop
        @stack << apply(operator, number1, number2)
      end
    end

    @stack.first
  end

  private

  def apply(operator, number1, number2)
    case operator
    when "*"
      number1 * number2
    when "/"
      number1 / number2
    when "-"
      number1 - number2
    when "+"
      number1 + number2
    end
  end
end
