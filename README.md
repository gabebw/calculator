# Calculator

Let's make a calculator. So far every one of the calculators works like this:

* Lexer: takes a string like `1 + 2` and turns it into tokens tagged with their
  type and value
* Parser: takes the lexer's tokens and uses the [shunting-yard
  algorithm][shunting] to output tokens in reverse polish notation.
* Interpreter: takes the RPN stack (like `1 2 +`) and applies operators (like
  `+`) to the numbers. It ends up with a single number (`3` in the example).

[shunting]: http://en.wikipedia.org/wiki/Shunting-yard_algorithm
