module Main (main) where

import Control.Monad (foldM)

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

validateBrackets :: Monad m => String -> (Int -> Char -> m Int) -> m Int
validateBrackets str  step =  do
  final <- foldM step 0 str
  if final == 0 then final
  else if final > 0 then Left "Unbalanced parens: too many opening"
  else final

main :: IO ()
main = do
    putStrLn "hello"
    putStrLn $ show $ validateBrackets "(())" step
    putStrLn $ show $ validateBrackets ")" stepEither 
    putStrLn $ show $ validateBrackets "(()" stepEither 
