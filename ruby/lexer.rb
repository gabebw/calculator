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
      elsif negative_number_allowed? && negative_number = chunk[/\A(\-[\d\.]+)/, 1]
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

  private

  # Should we interpret "-3.5" as a negative number, or as "subtract 3.5", i.e.
  # as "3.5" with the "-" operator in front of it?
  def negative_number_allowed?
    # Two cases where it's allowed:
    # 1) It's the first token (@tokens is empty),
    # 2) We just added an operator, like "3 + -5"
    @tokens.empty? ||
      latest_token_is_operator?
  end

  def latest_token_is_operator?
    last_token_type = @tokens.last[0]
    last_token_type == :OPERATOR
  end
end
