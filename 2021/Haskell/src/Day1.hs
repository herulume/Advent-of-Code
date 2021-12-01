module Day1
  ( p1
  , p2
  ) where

input :: IO [Int]
input = (fmap read . lines) <$> readFile "day1.txt"

collapseBy :: Ord a => Int -> [a] -> Int
collapseBy n = checkLesser . window  where
   checkLesser = length . filter (uncurry (<))
   window = zip <*> (drop n)
   
p1 :: IO ()
p1 = input >>= print . collapseBy 1 

p2 :: IO ()
p2 = input >>= print . collapseBy 3
