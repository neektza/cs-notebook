data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show)

singleton :: a -> Tree a  
singleton x = Node x EmptyTree EmptyTree  
  
insert :: (Ord a) => a -> Tree a -> Tree a  
insert x EmptyTree = singleton x  
insert x (Node a l r)
	| x == a = Node x l r
	| x < a  = Node a (insert x l) r
	| x > a  = Node a l (insert x r)

is_member :: (Ord a) => a -> Tree a -> Bool
is_member x EmptyTree = False
is_member x (Node a l r)
	| x == a = True
	| x < a  = is_member x l
	| x > a  = is_member x r
