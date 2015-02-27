module Nodes where

import Data.Function (on)

data Operator = Plus | Minus | Times deriving (Eq, Show)

precedence :: Operator -> Int
precedence Plus = 1
precedence Minus = 1
precedence Times = 2

instance Ord Operator where
    compare = compare `on` precedence

data Node = OperatorNode { operator :: Operator } | NumberNode { value :: Float }
instance Show Node where
    show (NumberNode f) = "NumberNode " ++ (show f)
    show (OperatorNode o) = show o
