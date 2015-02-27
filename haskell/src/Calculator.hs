module Calculator where

import Text.ParserCombinators.Parsec

-- number
-- (operator number)+

data Node a = Operator Char | Number Float
instance Show (Node a) where
    show (Operator c) = "Operator " ++ [c]
    show (Number f) = "Number " ++ (show f)

evaluateExpression  :: String -> Maybe ([Node a])
evaluateExpression input =
    case parse parser "(unknown)" input of
    Left parseError -> Nothing
    Right result -> Just result

parser :: Parser [Node a]
parser = expressionParser

expressionParser :: Parser [Node a]
expressionParser = do
    number <- numberParser
    spaces
    nodes <- many furtherExpressionParser
    return $ [Number (read number)] ++ (concat nodes)

furtherExpressionParser :: Parser [Node a]
furtherExpressionParser = do
    spaces
    operator <- operatorParser
    spaces
    number <- numberParser
    return $ [Operator operator, Number (read number)]

integerParser :: Parser String
integerParser = many digit

numberParser :: Parser String
numberParser = integerParser

operatorParser :: Parser Char
operatorParser = char '+'
