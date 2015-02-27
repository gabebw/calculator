module Parser (evaluateExpression) where

import Text.ParserCombinators.Parsec
import Nodes

evaluateExpression  :: String -> Maybe ([Node])
evaluateExpression input =
    case parse parser "(unknown)" input of
    Left parseError -> Nothing
    Right result -> Just result

parser :: Parser [Node]
parser = expressionParser

expressionParser :: Parser [Node]
expressionParser = do
    number <- numberParser
    spaces
    nodes <- many furtherExpressionParser
    return $ [NumberNode (read number)] ++ (concat nodes)

furtherExpressionParser :: Parser [Node]
furtherExpressionParser = do
    spaces
    opChar <- operatorParser
    spaces
    number <- numberParser
    return $ [OperatorNode (operatorFromChar opChar), NumberNode (read number)]

integerParser :: Parser String
integerParser = many digit

numberParser :: Parser String
numberParser = integerParser

operatorParser :: Parser Char
operatorParser = oneOf "+-*"

operatorFromChar :: Char -> Operator
operatorFromChar '+' = Plus
operatorFromChar '-' = Minus
operatorFromChar '*' = Times
operatorFromChar _ = error "OH NO"
