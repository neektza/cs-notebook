import qualified Data.Maybe as Maybe

type Id = String
type Table = [(Id, Integer)]

emptyTable = []
sampleTable = [("a", 1337), ("b", 7889)]

my_lookup :: Id -> Table -> Maybe Integer  
my_lookup key = foldr (\(k,v) acc -> if key == k then Just v else acc) Nothing

my_map :: (x -> y) -> [x] -> [y]
my_map f [] = []
my_map f (x:xs) = y : my_map f xs
	where y = f x

map_accumul :: (acc -> x -> (acc, y)) -> acc -> [x] -> (acc, [y])
map_accumul f s [] = (s, [])
map_accumul f s (x:xs) = let (s', y) = f s x in
							 let (s'', ys) = map_accumul f s' xs in
								 (s'', y:ys) 

-- map_accumul f s (x:xs) = map_accumul f s' xs
-- 	where (s', y) = f s x

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

-- Statements
interpStm :: Stm -> Table -> Table

interpStm (PrintStm []) t = t
interpStm (PrintStm (e:exps)) t = undefined
interpStm (CompoundStm s1 s2) t = undefined

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
