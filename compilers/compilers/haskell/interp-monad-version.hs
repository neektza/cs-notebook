import qualified Data.Maybe as Maybe
import Data.List (findIndex, elemIndex)

type Id = String
type Table = [(Id, Integer)]
type Effects = [String]

emptyTable = []
sampleTable = [("a", 1337), ("b", 7889)]

my_lookup :: Id -> Table -> Maybe Integer  
my_lookup key = foldr (\(k,v) acc -> if key == k then Just v else acc) Nothing

data BinOp = Plus | Minus | Times | Div deriving (Show)

data Stm = CompoundStm Stm Stm
         | AssignStm Id Exp
         | PrintStm [Exp] deriving (Show)

data Exp = IdExp Id
		 | NumExp Integer
		 | OpExp Exp BinOp Exp
		 | EseqExp Stm Exp deriving (Show)


calc :: BinOp -> Exp -> Exp -> Maybe Integer
calc Plus (NumExp x) (NumExp y) = Just (x + y)
calc Minus (NumExp x) (NumExp y) = Just (x - y)
calc Times (NumExp x) (NumExp y) = Just (x * y)
calc Div (NumExp x) (NumExp y) = Just (div x y)
calc _ _ _ = Nothing

interpPrint :: Exp -> Table -> IO ()
interpPrint exp t = print value
	where (value, _) = interpExp exp t

-- Statements
interpStm :: Stm -> Table -> (Effects, Table)

interpStm (PrintStm []) t efs = (efs, t)
interpStm (PrintStm (e:exps)) t efs = interpStm (PrintStm exps) newWorld
	where (result, newWorld) = interpExp e t

interpStm (CompoundStm s1 s2) t = do
	interpStm s1 t
	interpStm s2 t

interpStm (AssignStm id e) t = (id, res) : newWorld
	where (res, newWorld) = interpExp e t


-- Expressions
interpExp :: Exp -> Table -> (Integer, Table)

interpExp (EseqExp s e) t = do
	let newWorld = interpStm s t
	interpExp e newWorld

interpExp (NumExp num) t = (num, t)

interpExp (IdExp id) t = (lookup_result, t)
	where lookup_result = case my_lookup id t of
		  Just i -> i
		  Nothing -> 42

interpExp (OpExp x op y) t = (result, t)
	where result = case (calc op) x y of
		  Just x -> x
		  Nothing -> 42

--- Test data

prog = (CompoundStm (AssignStm "a" (OpExp (NumExp 5) Plus (NumExp 3))) (CompoundStm (AssignStm "b" (EseqExp (PrintStm [(IdExp "a"), (OpExp (IdExp "a") Minus (NumExp 1))]) (OpExp (NumExp 10) Times (IdExp "a")))) (PrintStm [(IdExp "b")]))) 
binexp1 = OpExp (NumExp 11) Minus (NumExp 3)
binexp2 = OpExp (NumExp 11) Div (NumExp 3) 
idexp = IdExp "a"
