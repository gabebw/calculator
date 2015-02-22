class Lexer
  OPERATORS = %w(+ * - /)
  OPERATOR_REGEX = Regexp.union(*OPERATORS)

  def initialize(text)
    @text = text
    @tokens = []
  end

  attr_reader :tokens

  def tokenize
    i = 0
    while i < @text.size
      chunk = @text[i..-1]
      if number = chunk[/\A([\d\.]+)/, 1]
        @tokens << [:NUMBER, number]
        i += number.size
      elsif negative_number = chunk[/\A(\-[\d\.]+)/, 1]
        @tokens << [:NUMBER, negative_number]
        i += negative_number.size
      elsif space = chunk[/\A(\s+)/, 1]
        # Ignore spaces
        i += space.size
      elsif operator = chunk[/\A(#{OPERATOR_REGEX})/, 1]
        @tokens << [:OPERATOR, operator]
        i += operator.size
      end
    end
  end
end
