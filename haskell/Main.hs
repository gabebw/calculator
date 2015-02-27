import qualified MonadicParser as MP (evaluateExpression)
import qualified ApplicativeParser as AP (evaluateExpression)
import Rpn (evalToRpn)
import Interpreter (interpret)

main :: IO ()
main = do
    print monadicRpnNodes
    print $ "[MonadicParser]     Should be " ++ show expectedResult  ++ ": " ++ (show $ interpret monadicRpnNodes)
    print applicativeRpnNodes
    print $ "[ApplicativeParser] Should be " ++ show expectedResult  ++ ": " ++ (show $ interpret applicativeRpnNodes)
    where
        expectedResult = 1 * 2 + 3 * 4 :: Float
        monadicRpnNodes = maybe [] evalToRpn $ MP.evaluateExpression "1 * 2+3 * 4"
        applicativeRpnNodes = maybe [] evalToRpn $ AP.evaluateExpression "1 * 2+3 * 4"
