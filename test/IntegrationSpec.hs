{-
-- EPITECH PROJECT, 2024
-- GLaDOS
-- File description:
-- GladosSpec.hs
-}

module IntegrationSpec (spec) where

import System.Process
import System.Exit (ExitCode(ExitSuccess))
import System.Exit (ExitCode(ExitFailure))
import System.Directory
import System.FilePath ((</>))
import Test.Hspec

defaultFilePath :: FilePath -> IO FilePath
defaultFilePath envVar = do
  currentDir <- getCurrentDirectory
  let filename = envVar
  return $ currentDir </> "test" </> "examples" </> filename

callTestOne :: Spec
callTestOne = do
  describe "call" $ do
    it "correctly evaluates the example from examples/test_one.scm" $ do
      exePath <- makeAbsolute "./glados"
      inputPath <- defaultFilePath "test_one.scm"
      inputContent <- readFile inputPath
      (exitCode, output, _) <- readProcessWithExitCode exePath [] inputContent
      exitCode `shouldBe` ExitSuccess
      output `shouldBe` "x: -5 !\ntest\n\n4\n"

callTestTwo :: Spec
callTestTwo = do
  describe "call" $ do
    it "correctly evaluates the example from examples/test_two.scm" $ do
      exePath <- makeAbsolute "./glados"
      inputPath <- defaultFilePath "test_two.scm"
      inputContent <- readFile inputPath
      (exitCode, output, _) <- readProcessWithExitCode exePath [] inputContent
      exitCode `shouldBe` ExitFailure 84
      output `shouldBe` "Exception: Stack overflow\n"

callTestThree :: Spec
callTestThree = do
  describe "call" $ do
    it "correctly evaluates the example from examples/test_three.scm" $ do
      exePath <- makeAbsolute "./glados"
      inputPath <- defaultFilePath "test_three.scm"
      inputContent <- readFile inputPath
      (exitCode, output, _) <- readProcessWithExitCode exePath [] inputContent
      exitCode `shouldBe` ExitSuccess
      output `shouldBe` "3\n260\n34\n530\n3\n"

callTestFour :: Spec
callTestFour = do
  describe "call" $ do
    it "correctly evaluates the example from examples/test_four.scm" $ do
      exePath <- makeAbsolute "./glados"
      inputPath <- defaultFilePath "test_four.scm"
      inputContent <- readFile inputPath
      (exitCode, output, _) <- readProcessWithExitCode exePath [] inputContent
      exitCode `shouldBe` ExitSuccess
      output `shouldBe` "3\n3\n4\n"

callTestFive :: Spec
callTestFive = do
  describe "call" $ do
    it "correctly evaluates the example from examples/test_five.scm" $ do
      exePath <- makeAbsolute "./glados"
      inputPath <- defaultFilePath "test_five.scm"
      inputContent <- readFile inputPath
      (exitCode, output, _) <- readProcessWithExitCode exePath [] inputContent
      exitCode `shouldBe` ExitSuccess
      output `shouldBe` "2\n4\n"

callTestFact :: Spec
callTestFact = do
  describe "call" $ do
    it "correctly evaluates the example from examples/test_factorial.scm" $ do
      exePath <- makeAbsolute "./glados"
      inputPath <- defaultFilePath "test_factorial.scm"
      inputContent <- readFile inputPath
      (exitCode, output, _) <- readProcessWithExitCode exePath [] inputContent
      exitCode `shouldBe` ExitSuccess
      output `shouldBe` "3628800\n"

callTestSumOfInt :: Spec
callTestSumOfInt = do
  describe "call" $ do
    it "correctly evaluates the example from examples/test_sum_of_integers.scm" $ do
      exePath <- makeAbsolute "./glados"
      inputPath <- defaultFilePath "test_sum_of_integers.scm"
      inputContent <- readFile inputPath
      (exitCode, output, _) <- readProcessWithExitCode exePath [] inputContent
      exitCode `shouldBe` ExitSuccess
      output `shouldBe` "15\n"

callTestFibonacci :: Spec
callTestFibonacci = do
  describe "call" $ do
    it "correctly evaluates the example from examples/test_fibonacci.scm" $ do
      exePath <- makeAbsolute "./glados"
      inputPath <- defaultFilePath "test_fibonacci.scm"
      inputContent <- readFile inputPath
      (exitCode, output, _) <- readProcessWithExitCode exePath [] inputContent
      exitCode `shouldBe` ExitSuccess
      output `shouldBe` "0\n1\n1\n2\n3\n5\n8\n13\n21\n34\n55\n"

callTestReturn :: Spec
callTestReturn = do
  describe "call" $ do
    it "correctly evaluates the example from examples/test_return.scm" $ do
      exePath <- makeAbsolute "./glados"
      inputPath <- defaultFilePath "test_return.scm"
      inputContent <- readFile inputPath
      (exitCode, output, _) <- readProcessWithExitCode exePath [] inputContent
      exitCode `shouldBe` ExitSuccess
      output `shouldBe` "1\n"

callTestDoWhile :: Spec
callTestDoWhile = do
  describe "call" $ do
    it "correctly evaluates the example from examples/test_do_while.scm" $ do
      exePath <- makeAbsolute "./glados"
      inputPath <- defaultFilePath "test_do_while.scm"
      inputContent <- readFile inputPath
      (exitCode, output, _) <- readProcessWithExitCode exePath [] inputContent
      exitCode `shouldBe` ExitSuccess
      output `shouldBe` "a\n"

spec :: Spec
spec = do
    callTestOne
    callTestTwo
    callTestThree
    callTestFour
    callTestFive
    callTestFact
    callTestFibonacci
    callTestReturn
    callTestDoWhile
