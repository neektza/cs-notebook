-- Greeting parser from scratch using parser combinators

data Greeting = Bok | MozdaBok String | NoBok deriving (Show)
data Dots = Dots Int deriving (Show)

input1 = "..........book............"

dotParser :: String -> (Dots, String)
dotParser str = dotCounter (Dots 0, str)

bokParser :: String -> (Greeting, String)
bokParser str = bokMachine (NoBok, str)

greetingParser :: String -> (Dots, Greeting)
greetingParser s = (prvi, drugi)
	where (prvi, drugi, _) = sequencer (Dots 0, NoBok, s)

-- Low level stuff

sequencer :: (Dots, Greeting, String) -> (Dots, Greeting, String)
sequencer (Dots 0, NoBok, s) = case dotParser s of
								  (Dots 0, rest) -> sequencer(Dots 0, NoBok, rest)
								  (Dots x, rest) -> sequencer(Dots x, NoBok, rest)
sequencer (Dots x, NoBok, s) = case bokParser s of
								  (NoBok, rest) -> sequencer(Dots x, NoBok, rest)
								  (Bok, rest) -> sequencer(Dots x, Bok, rest)
sequencer (Dots x, Bok, s) = case dotParser s of
							   (Dots 0, rest) -> (Dots x, Bok, rest)
							   (Dots y, rest) -> (Dots (x+y), Bok, rest)


bokMachine :: (Greeting, String) -> (Greeting, String)
bokMachine (NoBok         , 'b':rest) = bokMachine (MozdaBok "b"  , rest)
bokMachine (MozdaBok "b"  , 'o':rest) = bokMachine (MozdaBok "bo" , rest)
bokMachine (MozdaBok "bo" , 'k':rest) = bokMachine (Bok           , rest)
bokMachine (NoBok         , rest) = (NoBok                        , rest)
bokMachine (Bok           , rest) = (Bok                          , rest)

dotCounter :: (Dots, String) -> (Dots, String)
dotCounter ((Dots 0), "") = (Dots 0, "")
dotCounter ((Dots acc), ('.':rest)) = dotCounter (Dots (acc+1), rest)
dotCounter ((Dots acc), (rest)) = (Dots acc, rest)
