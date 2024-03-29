{-
-- EPITECH PROJECT, 2024
-- GLaDOS
-- File description:
-- VM.hs
-}

module VM (startVM, execOpADD, execOpSUB, execOpMUL, execOpDIV, execOpMOD, execOpEQUAL, execOpLESS, remInst, execJumpIfFalse, exec, parseVM) where

import Data.Word
import File
import System.Exit
import Types
import Utils

execOpADD :: Insts -> Stack -> Either String Value
execOpADD insts ((IntVM i1):(IntVM i2):stack) =
    exec insts ((IntVM $ i1 + i2) : stack)
execOpADD _ _ = Left "ADD need two integers"

execOpSUB :: Insts -> Stack -> Either String Value
execOpSUB insts ((IntVM i1):(IntVM i2):stack) =
    exec insts ((IntVM $ i1 - i2) : stack)
execOpSUB _ _ = Left "SUB need two integers"

execOpMUL :: Insts -> Stack -> Either String Value
execOpMUL insts ((IntVM i1):(IntVM i2):stack) =
    exec insts ((IntVM $ i1 * i2) : stack)
execOpMUL _ _ = Left "MUL need two integers"

execOpDIV :: Insts -> Stack -> Either String Value
execOpDIV _ ((IntVM _):(IntVM 0):_) = Left "division by 0"
execOpDIV insts ((IntVM i1):(IntVM i2):stack) =
    exec insts ((IntVM $ i1 `div` i2) : stack)
execOpDIV _ _ = Left "DIV need two integers"

execOpMOD :: Insts -> Stack -> Either String Value
execOpMOD _ ((IntVM _):(IntVM 0):_) = Left "modulo by 0"
execOpMOD insts ((IntVM i1):(IntVM i2):stack) =
    exec insts ((IntVM $ i1 `mod` i2) : stack)
execOpMOD _ _ = Left "MOD need two integers"

execOpEQUAL :: Insts -> Stack -> Either String Value
execOpEQUAL insts ((IntVM i1):(IntVM i2):stack) =
    exec insts ((BoolVM $ i1 == i2) : stack)
execOpEQUAL insts ((BoolVM b1):(BoolVM b2):stack) =
    exec insts ((BoolVM $ b1 == b2) : stack)
execOpEQUAL _ _ = Left "EQUAL need two arguments"

execOpLESS :: Insts -> Stack -> Either String Value
execOpLESS insts ((IntVM i1):(IntVM i2):stack) =
    exec insts ((BoolVM $ i1 < i2) : stack)
execOpLESS insts ((BoolVM b1):(BoolVM b2):stack) =
    exec insts ((BoolVM $ b1 < b2) : stack)
execOpLESS _ _ = Left "LESS need two arguments"

remInst :: Int -> Insts -> Insts
remInst _ [] = []
remInst i (x:xs) | i > 0 = remInst (i - 1) xs
                 | otherwise = x : xs

execJumpIfFalse :: Int -> Insts -> Stack -> Either String Value
execJumpIfFalse i insts ((BoolVM False):stack) = exec (remInst i insts) stack
execJumpIfFalse i insts ((IntVM 0):stack) = exec (remInst i insts) stack
execJumpIfFalse _ insts stack = exec insts stack

exec :: Insts -> Stack -> Either String Value
exec ((CallOp ADD):insts) stack = execOpADD insts stack
exec ((CallOp SUB):insts) stack = execOpSUB insts stack
exec ((CallOp MUL):insts) stack = execOpMUL insts stack
exec ((CallOp DIV):insts) stack = execOpDIV insts stack
exec ((CallOp MOD):insts) stack = execOpMOD insts stack
exec ((CallOp EQUAL):insts) stack = execOpEQUAL insts stack
exec ((CallOp LESS):insts) stack = execOpLESS insts stack
exec ((Push value):insts) stack = exec insts (value : stack)
exec (Ret:_) (value:_) = Right value
exec ((JumpIfFalse i):insts) stack = execJumpIfFalse i insts stack
exec ((Jump i):insts) stack = exec (remInst i insts) stack
exec _ _ = Left "no value to return"

continueParsing :: Instruction -> [Word8] -> Maybe Insts
continueParsing inst xs =
    case parseVM xs of
        Just [] -> Just [inst]
        Just insts -> Just $ inst : insts
        Nothing -> Nothing

readPush :: [Word8] -> Maybe Insts
readPush (b1:b2:b3:b4:xs) =
    continueParsing (Push $ IntVM $ bytesToInt b1 b2 b3 b4) xs
readPush _ = Nothing

readCall :: [Word8] -> Maybe Insts
readCall (0x00:xs) = continueParsing (CallOp ADD) xs
readCall (0x01:xs) = continueParsing (CallOp SUB) xs
readCall (0x02:xs) = continueParsing (CallOp MUL) xs
readCall (0x03:xs) = continueParsing (CallOp DIV) xs
readCall (0x04:xs) = continueParsing (CallOp MOD) xs
readCall (0x05:xs) = continueParsing (CallOp EQUAL) xs
readCall (0x06:xs) = continueParsing (CallOp LESS) xs
readCall _ = Nothing

readJumpIfFalse :: [Word8] -> Maybe Insts
readJumpIfFalse (b1:b2:b3:b4:xs) =
    continueParsing (JumpIfFalse $ bytesToInt b1 b2 b3 b4) xs
readJumpIfFalse _ = Nothing

readJump :: [Word8] -> Maybe Insts
readJump (b1:b2:b3:b4:xs) =
    continueParsing (Jump $ bytesToInt b1 b2 b3 b4) xs
readJump _ = Nothing

parseVM :: [Word8] -> Maybe Insts
parseVM [] = Just []
parseVM (0x00:xs) = readPush xs
parseVM (0x01:xs) = readCall xs
parseVM (0x02:xs) = continueParsing Ret xs
parseVM (0x03:xs) = readJumpIfFalse xs
parseVM (0x04:xs) = readJump xs
parseVM _ = Nothing

startVM :: String -> IO ()
startVM file = do
    binaryFile <- readBinary file
    case binaryFile of
        Left err -> putStrLn err >> exitWith (ExitFailure 84)
        Right binary -> case parseVM binary of
                Just insts -> case exec insts [] of
                        Left err -> putStrLn $ "Error: " ++ err
                        Right value -> putStrLn $ show value
                Nothing -> putStrLn "Error: binary corrupted" >>
                    exitWith (ExitFailure 84)
