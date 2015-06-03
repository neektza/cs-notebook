{-# LANGUAGE OverloadedStrings, ViewPatterns, BangPatterns #-}

module Main where

import Control.Monad
import Data.List
import Data.Text (split, strip)
import Data.Graph

csv = concat . (intersperse ",")
cadr = head . tail

convertToTuples :: String -> (Int, Int)
convertToTuples line = (e1, e2)
	where
		e1 = read (head inList) :: Int
		e2 = read (cadr inList) :: Int
		inList = words line

main = do
	fileContents <- getContents
	let edges =  map convertToTuples (lines fileContents)
	let g = graphFromEdges edges
	putStrLn g
