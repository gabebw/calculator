module Parser (evaluateExpression) where

import Text.ParserCombinators.Parsec
import Nodes

evaluateExpression  :: String -> Maybe ([Node])
evaluateExpression input =
    case parse parser "(unknown)" input of
    Left _ -> Nothing
    Right result -> Just result

parser :: Parser [Node]
parser = expressionParser

expressionParser :: Parser [Node]
expressionParser = do
    numberNode <- numberNodeParser
    spaces
    nodes <- many furtherExpressionParser
    return $ [numberNode] ++ (concat nodes)

-- sequence turns `[Parser Node]` into `Parser [Node]`
furtherExpressionParser :: Parser [Node]
furtherExpressionParser = sequence [operatorNodeParser, numberNodeParser]

numberNodeParser :: Parser Node
numberNodeParser = do
    spaces
    fmap NumberNode integerParser

integerParser :: Parser Float
integerParser = fmap read $ many digit

operatorNodeParser :: Parser Node
operatorNodeParser = do
    spaces
    (fmap (OperatorNode . operatorFromChar) $ oneOf operatorChars)

operatorChars :: [Char]
operatorChars = "+-*"

operatorFromChar :: Char -> Operator
operatorFromChar '+' = Plus
operatorFromChar '-' = Minus
operatorFromChar '*' = Times
operatorFromChar _ = error "OH NO"
