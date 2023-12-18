module ParserList where
import Data.Char (isDigit, isSpace)
import Control.Applicative

-- Basic Parser
newtype Parser a = Parser { runParser :: String -> Maybe (a, String) }

instance Functor Parser where
    -- Allow mapping of function on first value of parser
    fmap f (Parser p) = Parser $ \input ->
        fmap (\(a, rest) -> (f a, rest)) (p input)

instance Applicative Parser where
    -- Inject value in parser
    pure a = Parser $ \input -> Just (a, input)

    -- combine parser of char & int
    (Parser p1) <*> (Parser p2) = Parser $ \input ->
        case p1 input of
            Just (f, rest) ->
                fmap (\(a, rest') -> (f a, rest')) (p2 rest)
            Nothing -> Nothing

-- Instance Alternative
instance Alternative Parser where
    -- Error_handling
    empty = Parser $ const Nothing

    -- If one parser fail (like only int and char parser fail, use the onter here int parser)
    (Parser p1) <|> (Parser p2) = Parser $ \input ->
        p1 input <|> p2 input

-- Apply parsing and print
parse :: Show a => Parser a -> String -> IO ()
parse p input = do
    case runParser p input of
        Just (result, rest) -> do
            putStrLn $ "Parsing succeeded. Result: " ++ show result
            putStrLn $ "Remaining input: " ++ rest
        Nothing -> putStrLn "Parsing failed"

-- Parse Int
parseInt :: Parser Int
parseInt = read <$> some (satisfy isDigit)

-- Satisfy : condition for parsing authorization
satisfy :: (Char -> Bool) -> Parser Char
satisfy pred = Parser f
  where
    f (y:ys) | pred y    = Just (y, ys)
            | otherwise = Nothing
    f []                 = Nothing

-- Parse a list
parseList :: Parser a -> Parser [a]
parseList p = char '(' *> spaces *> elements <* char ')' <* spaces
  where
    elements = (:) <$> p <*> many (spaces *> char ',' *> spaces *> p)

-- Parse a char c
char :: Char -> Parser Char
char c = satisfy (== c)

-- Parseur pour les espaces
spaces :: Parser String
spaces = many (satisfy isSpace)
