-- Greeting parser from scratch using parser combinators

data Bok = Bok | NoBok deriving (Show)

data Mozda x = Ipak x | Nista deriving (Show)

data Greeting = DotsAnd Int Greeting
			  | GreetAnd Bok Greeting
			  | Greet Bok
			  | Dots Int deriving (Show)

input = "...........boooook..........."

greetingParser :: String -> Mozda Greeting
greetingParser str = case dotCounter str of
	(0, rest) -> case bokMachine rest of
		(NoBok, rest) -> Nista
		(Bok, rest) -> case dotCounter rest of
			(0, rest) -> Ipak (Greet Bok)
			(x, rest) -> Ipak (GreetAnd Bok (Dots x))
	(x, rest) -> case bokMachine rest of
		(NoBok, rest) -> Ipak (Dots x)
		(Bok, rest) -> case dotCounter rest of
			(0, rest) -> Ipak (DotsAnd x (Greet Bok))
			(y, rest) -> Ipak (DotsAnd x (GreetAnd Bok (Dots y)))

--- Low level machines

dotCounter :: String -> (Int, String)
dotCounter s = cnt 0 s
	where
		cnt 0 "" = (0, "")
		cnt acc ('.':tail) = cnt (succ acc) tail
		cnt 0 s = (0, s)
		cnt acc s = (acc, s)

bokMachine :: String -> (Bok, String)
bokMachine ('b':tail) = case samooovi tail of
							 ('k':tail2) -> (Bok, tail2)
							 _		   -> (NoBok, 'b':tail)
			where
				samooovi ('o':tail) = samooovi tail
				samooovi tail = tail

bokMachine s = (NoBok, s)
