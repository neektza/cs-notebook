-- Integer algebra parser from scratch using parser combinators
-- 3 + 2

import Data.Char

data Exp = NumExp Int
		 | OpExp Exp Op Exp deriving (Show)

data Op = Plus | Minus | Times | Div | Wat deriving (Show)
data Digit = Digit Int | Qua deriving (Show)

convertToDigit :: Char -> Digit
convertToDigit c = if isNumber c 
			   then Digit (digitToInt c)
			   else Qua

convertToOp :: Char -> Op
convertToOp c = case c of 
				  '+' -> Plus
				  '-' -> Minus
				  '*' -> Times
				  '/' -> Div
				  _ -> Wat

parseExp :: (Exp, String) -> (Exp, String)
parseExp (exp, (char:rest)) = case convertToDigit char of
						 (Digit x) -> (NumExp x, rest)
						 (Qua)	   -> case

input = "3 + 2"


