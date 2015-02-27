module Interpreter (interpret) where

import Nodes

interpret :: [Node a] -> Float
interpret nodes = interpret' nodes []

interpret' :: [Node a] -> [Node a] -> Float
interpret' (n@(NumberNode _):xs) stack = interpret' xs (stack ++ [n])
interpret' (op@(OperatorNode o):xs) ((NumberNode f1):(NumberNode f2):ss) =
	interpret' xs (ss ++ [result])
	where
		result = applyOperator f1 f2 o

interpret' [] ((NumberNode f):[]) = f
interpret' _ _ = error "OH NO"

applyOperator :: Float -> Float -> Operator -> Node a
applyOperator f1 f2 Plus = NumberNode (f1 + f2)
applyOperator f1 f2 Minus = NumberNode (f1 - f2)
applyOperator f1 f2 Times = NumberNode (f1 * f2)
