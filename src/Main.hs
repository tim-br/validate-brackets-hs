{-# LANGUAGE FlexibleInstances #-}

module Main (main) where

import Control.Monad (foldM)

instance MonadFail (Either String) where
    fail = Left

stepMaybe :: Int -> Char -> Maybe Int
stepMaybe acc char =
    case char of
        '(' -> Just $ acc + 1
        ')' -> Just $ acc - 1
        _ -> Nothing

stepEither :: Int -> Char -> Either String Int
stepEither acc char =
    case char of
        '(' -> Right $ acc + 1
        ')' -> if acc - 1 < 0 then Left "Unbalanced parens" else Right $ acc - 1
        _ -> Left "Invalid Char"

validateBrackets :: (MonadFail m) => String -> (Int -> Char -> m Int) -> m String
validateBrackets str step = do
    final <- foldM step 0 str
    if final == 0
        then pure "Success"
        else fail "Unbalanced parens"

main :: IO ()
main = do
    putStrLn "Running validateBrackets ..."
    putStrLn $ show $ validateBrackets "(())" stepEither
    putStrLn $ show $ validateBrackets "()" stepMaybe
    putStrLn $ show $ validateBrackets "(()" stepEither
