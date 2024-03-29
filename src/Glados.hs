{-
-- EPITECH PROJECT, 2023
-- GLaDOS
-- File description:
-- Glados.hs
-}

module Glados (start) where

import CommandLines
import Compiler
import Disassembler
import Eval (evalASTS)
import Parser (parse)
import System.Environment
import System.Exit
import System.IO
import Types
import VM

getInput :: IO (String)
getInput = isEOF >>= \eof ->
    case eof of
        True -> return []
        False -> getLine >>= \line ->
            getInput >>= \rest ->
            return $ line ++ rest

start :: IO ()
start = getArgs >>= \args -> case args of
        ("--compile":file:_) -> startInterpreter $ Just file
        ("--compile":_)      -> putStrLn "--compile argument needs a file"
        ("--disassemble":file:_) -> disassemble file
        ("--disassemble":_)      -> putStrLn "--disassemble needs a file"
        ("--vm":file:_)      -> startVM file
        ("--vm":_)           -> putStrLn "--vm argument needs a file"
        ("--man":_)          -> manCommand
        ("--help":_)         -> helpCommand
        _                    -> startInterpreter Nothing

startInterpreter :: Maybe String -> IO ()
startInterpreter file = getInput >>= \input ->
    case runParser parse input of
        Just (asts, []) ->
            case file of
                Just path -> compile asts path
                Nothing -> evalASTS 1 asts [] >>= \_ -> return ()
        _ -> putStrLn "Exception: Parser error" >> exitWith (ExitFailure 84)
