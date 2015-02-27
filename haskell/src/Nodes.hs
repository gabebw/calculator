module Nodes where

import Data.Function (on)

data Operator = Plus | Minus | Times deriving (Eq, Show)

precedence :: Operator -> Int
precedence Plus = 1
precedence Minus = 1
precedence Times = 2

instance Ord Operator where
    compare = compare `on` precedence

data Node a = OperatorNode { operator :: Operator } | NumberNode Float
instance Show (Node a) where
    show (NumberNode f) = "NumberNode " ++ (show f)
    show (OperatorNode o) = show o
