import Data.List
 
type Vert = Int
type Edge = (Vert,Vert)
type Graph = ([Vert],[Vert])
 
depthfirst :: Graph -> Vert -> [Vert]
depthfirst (v,e) n
    | [x | x<-v,x==n] == [] = []
    | otherwise = dfrecursive (v,e) [n]
 
dfrecursive :: Graph -> [Vert] -> [Vert]
dfrecursive ([],_) _ = []
dfrecursive (_,_) [] = []
dfrecursive (v,e) (top:stack)
	| [x | x<-v,x==top] == [] = dfrecursive (newv, e) stack
	| otherwise = top : dfrecursive (newv, e) (adjacent ++ stack)
	where
		adjacent = [x | (x,y)<-e,y==top] ++ [x | (y,x)<-e,y==top]
		newv = [x | x<-v,x/=top]
 
connectedcomponents :: Graph -> [[Vert]]
connectedcomponents ([],_) = []
connectedcomponents (top:v,e) 
	| remaining == [] = [connected]
	| otherwise = connected : connectedcomponents (remaining, e)
	where
		connected = depthfirst (top:v,e) top
        remaining = (top:v) \\ connected
