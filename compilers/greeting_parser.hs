-- Greeting parser from scratch using parser combinators

data Bok = Bok | NoBok deriving (Show)

data Mozda x = Ipak x | Nista deriving (Show)

data Greeting = DotsAnd Int Greeting
			  | GreetAnd Bok Greeting
			  | Greet Bok
			  | Dots Int deriving (Show)


data Parser x = P (String -> Mozda (x, String))

input = "...........boooook..........."

greetingParser :: String -> Mozda (Greeting, String)
greetingParser str = case dotCounter str of
	(Ipak (0, rest)) -> case bokMachine rest of
		Nista -> Nista
		(Ipak (Bok, rest)) -> case dotCounter rest of
				(Nista) -> Ipak ((Greet Bok), rest)
				(Ipak (0, rest)) -> Ipak ((Greet Bok), rest)
				(Ipak (x, rest)) -> Ipak ((GreetAnd Bok (Dots x)), rest)
	(Ipak (x, rest)) -> case bokMachine rest of
		Nista -> Ipak ((Dots x), rest)
		(Ipak (Bok, rest)) -> case dotCounter rest of
			Nista -> Ipak ((DotsAnd x (Greet Bok)), rest)
			(Ipak (0, rest)) -> Ipak ((DotsAnd x (Greet Bok)), rest)
			(Ipak (y, rest)) -> Ipak ((DotsAnd x (GreetAnd Bok (Dots y))), rest)

--- Low level machines

dotCounter :: String -> Mozda (Int, String)
dotCounter s = cnt 0 s
	where
		cnt 0 "" = Nista
		cnt acc ('.':tail) = cnt (succ acc) tail
		cnt 0 s = Ipak (0, s)
		cnt acc s = Ipak (acc, s)

bokMachine :: String -> Mozda (Bok, String)
bokMachine ('b':tail) = case samooovi tail of
						  ('k':tail2) -> Ipak (Bok, tail2)
						  _		   -> Nista
			where
				samooovi ('o':tail) = samooovi tail
				samooovi tail = tail

bokMachine s = Nista
