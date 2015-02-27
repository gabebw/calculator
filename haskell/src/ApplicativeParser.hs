module ApplicativeParser (evaluateExpression) where

import Text.ParserCombinators.Parsec
import Nodes
-- *> "points at the value you want to keep" (throws away the left)
import Control.Applicative ((<$>), (<*>), (*>), pure)

evaluateExpression  :: String -> Maybe ([Node])
evaluateExpression input =
    case parse parser "(unknown)" input of
    Left _ -> Nothing
    Right result -> Just result

parser :: Parser [Node]
parser = expressionParser

expressionParser :: Parser [Node]
expressionParser = (:) <$> numberNodeParser <*> manyFurtherExpressionsParser

manyFurtherExpressionsParser :: Parser [Node]
manyFurtherExpressionsParser = concat <$> many1 furtherExpressionParser

-- sequence turns `[Parser Node]` into `Parser [Node]`
furtherExpressionParser :: Parser [Node]
furtherExpressionParser = sequence [operatorNodeParser, numberNodeParser]

numberNodeParser :: Parser Node
numberNodeParser = spaces *> (NumberNode <$> floatParser)

floatParser :: Parser Float
floatParser = read <$> (many1 digit)

operatorNodeParser :: Parser Node
operatorNodeParser = spaces *> operatorNode

operatorNode :: Parser Node
operatorNode = try (char '+' *> pure (OperatorNode Plus))
        <|> try (char '-' *> pure (OperatorNode Minus))
        <|> (char '*' *> pure (OperatorNode Times))
