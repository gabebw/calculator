module Calculator where

import Text.ParserCombinators.Parsec
import Data.Function (on)

-- number
-- (operator number)+

data Operator = Plus | Minus | Times deriving (Eq, Show)

precedence :: Operator -> Int
precedence Plus = 1
precedence Minus = 1
precedence Times = 2

instance Ord Operator where
    compare = compare `on` precedence

data Node a = OperatorNode Operator | NumberNode Float
instance Show (Node a) where
    show (NumberNode f) = "NumberNode " ++ (show f)
    show (OperatorNode o) = show o

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
    return $ [NumberNode (read number)] ++ (concat nodes)

furtherExpressionParser :: Parser [Node a]
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
operatorParser = char '+'

operatorFromChar :: Char -> Operator
operatorFromChar '+' = Plus
operatorFromChar '-' = Minus
operatorFromChar '*' = Times
operatorFromChar _ = error "OH NO"
