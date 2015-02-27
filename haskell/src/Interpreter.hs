module Interpreter (interpret) where

import Nodes

type OutputStack = [Node]

interpret :: [Node] -> Maybe Float
interpret nodes = interpret' nodes []

interpret' :: [Node] -> OutputStack -> Maybe Float
interpret' (n@(NumberNode _):xs) stack = interpret' xs (stack ++ [n])
interpret' ((OperatorNode o):xs) ((NumberNode f1):(NumberNode f2):ss) =
	interpret' xs (ss ++ [result])
	where
		result = applyOperator f1 f2 o

interpret' [] ((NumberNode f):[]) = Just f
interpret' [] [] = Nothing

applyOperator :: Float -> Float -> Operator -> Node
applyOperator f1 f2 Plus = NumberNode (f1 + f2)
applyOperator f1 f2 Minus = NumberNode (f1 - f2)
applyOperator f1 f2 Times = NumberNode (f1 * f2)
