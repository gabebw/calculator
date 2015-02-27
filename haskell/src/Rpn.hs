module Rpn (evalToRpn) where

import Nodes

evalToRpn :: [Node] -> [Node]
evalToRpn nodes = evalNode nodes ([], [])

evalNode :: [Node] -> ([Node], [Node]) -> [Node]
evalNode (n@(NumberNode _):xs) (output, operators) =
    evalNode xs ((output ++ [n]), operators)

evalNode (o@(OperatorNode o1):xs) (output, operators@(_:_:_)) =
    if o1 <= o2
        then evalNode xs (poperator o1 (output, operators))
    else
        evalNode xs (output, operators ++ [o])
    where
        o2 = operator (last operators)

evalNode (o:xs) (output, operators) =
    evalNode xs (output, operators ++ [o])

evalNode [] (output, operators) = output ++ (reverse operators)

poperator :: Operator -> ([Node], [Node]) -> ([Node], [Node])
poperator o1 (output, operators) =
    if o1 <= o2
        then poperator o1 (output ++ [lastOperator], init operators)
    else
        (output, operators ++ [OperatorNode o1])
    where
        o2 = operator lastOperator
        lastOperator = last operators
