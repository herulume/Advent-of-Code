module Main where

import qualified Day1
import qualified Day2

day1 :: [IO ()]
day1 = [ putStrLn "Day 1 solutions"
       , putStr "Part 1: " >> Day1.p1
       , putStr "Part 2: " >> Day1.p2
       ]

day2 :: [IO ()]
day2 = [ putStrLn "Day 2 solutions"
       , putStr "Part 1: " >> Day2.p1
       , putStr "Part 2: " >> Day2.p2
       ]
       

main :: IO ()
main = do
  sequence_ day1
  sequence_ day2

