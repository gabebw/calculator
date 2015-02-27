import Calculator (evaluateExpression)
import Rpn (eval)

main :: IO ()
main = print $ maybe [] eval $ evaluateExpression "1 * 2 + 3 * 4"
