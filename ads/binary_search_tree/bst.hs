module Main where

data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show)

singleton :: a -> Tree a
singleton a = Node a EmptyTree EmptyTree

bstInsert :: (Ord a) => a -> Tree a -> Tree a
bstInsert x EmptyTree = singleton x
bstInsert x (Node a left right)
	| x == a = Node a left right
	| x < a = Node a (bstInsert x left) right
	| x > a = Node a left (bstInsert x right)

bstElem :: (Ord a) => a -> Tree a -> Bool
bstElem x EmptyTree = False
bstElem x (Node a left right)
	| x == a = True
	| x < a = bstElem x left
	| x > a = bstElem x right

split :: String -> [String]
split [] = []
split [x:xs]
	| x <> ' ' = [x:split xs]
	| otherwise = 

main = do
	line <- getContents
	putStrLn line
