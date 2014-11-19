type Id = String

data Binop = Plus | Minus | Times | Div deriving (Show)

data Stm = CompoundStm Stm Stm
         | AssignStm Id Exp
         | PrintStm [Exp] deriving (Show)

data Exp = IdExp Id
		 | NumExp Int
		 | OpExp Exp Binop Exp
		 | EseqExp Stm Exp deriving (Show)


maxargs :: Stm -> Int
maxargs (PrintStm []) = 0
maxargs (PrintStm e_list) = length e_list
maxargs (AssignStm i e) = 0
maxargs (CompoundStm s1 s2) = maxargs s1 + maxargs s2

expand :: Exp -> Int
expand (IdExp _) = 0
expand (NumExp _) = 0
expand (OpExp _ _ _) = 0
expand (EseqExp s e) = maxargs s
    
prog :: Stm
prog = (CompoundStm (AssignStm "a" (OpExp (NumExp 5) Plus (NumExp 3))) (CompoundStm (AssignStm "b" (EseqExp (PrintStm [(IdExp "a"), (OpExp (IdExp "a") Minus (NumExp 1))]) (OpExp (NumExp 10) Times (IdExp "a")))) (PrintStm [(IdExp "b")]))) 
