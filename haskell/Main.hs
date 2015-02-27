import qualified MonadicParser as MP (evaluateExpression)
import Rpn (evalToRpn)
import Interpreter (interpret)

main :: IO ()
main = do
    print rpnNodes
    print $ "Should be " ++ show expectedResult  ++ ": " ++ (show $ interpret rpnNodes)
    where
        expectedResult = 1 * 2 + 3 * 4 :: Float
        rpnNodes = maybe [] evalToRpn $ MP.evaluateExpression "1 * 2+3 * 4"
