module Main where

import qualified Day1

day1 :: [IO ()]
day1 = [ putStrLn "Day 1 solutions"
       , putStr "Part 1: " >> Day1.p1
       , putStr "Part 2: " >> Day1.p2
       ]

main :: IO ()
main = sequence_ day1

