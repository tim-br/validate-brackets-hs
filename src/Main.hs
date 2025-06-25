{-# LANGUAGE FlexibleInstances #-}

module Main (main) where

import Control.Monad (foldM, MonadFail)

-- step :: Maybe Int -> Char -> Maybe Int
-- step acc char =
--    maybe
--        Nothing
--        ( \acc ->
--            case char of
--                '(' -> Just $ acc + 1
--                ')' -> Just $ acc - 1
--                _ -> Nothing
--        )
--        acc

instance MonadFail (Either String) where
  fail = Left

step :: Int -> Char -> Maybe Int
step acc char =
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

validateBrackets :: MonadFail m => String -> (Int -> Char -> m Int) -> m String 
validateBrackets str  step =  do
  final <- foldM step 0 str
  if final == 0 then return "Success"
  else fail "Unbalanced parens"

main :: IO ()
main = do
    putStrLn "hello"
    putStrLn $ show $ validateBrackets "(())" stepEither
    putStrLn $ show $ validateBrackets "()" step 
    putStrLn $ show $ validateBrackets "(()" stepEither 
