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
    numberNode <- numberNodeParser
    spaces
    nodes <- many furtherExpressionParser
    return $ [numberNode] ++ (concat nodes)

furtherExpressionParser :: Parser [Node]
furtherExpressionParser = do
    spaces
    op <- operatorParser
    spaces
    numberNode <- numberNodeParser
    return $ [OperatorNode op, numberNode]

numberNodeParser :: Parser Node
numberNodeParser = fmap NumberNode integerParser

integerParser :: Parser Float
integerParser = fmap read $ many digit

operatorParser :: Parser Operator
operatorParser = fmap operatorFromChar $ oneOf "+-*"

operatorFromChar :: Char -> Operator
operatorFromChar '+' = Plus
operatorFromChar '-' = Minus
operatorFromChar '*' = Times
operatorFromChar _ = error "OH NO"
