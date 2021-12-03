module Day3
  ( p1
  , p2
  ) where

import Control.Arrow ((&&&))
import Data.List (transpose)

cond p f g = (either f g) . (grd p) where
  grd :: (a -> Bool) -> a -> Either a a
  grd p x = if p x then Left x else Right x
  
input :: IO [String]
input = lines <$> readFile "day3.txt"

toInt :: String -> Int
toInt = foldl (\acc bit -> acc*2 + (read [bit])) 0

invertBin :: String -> String
invertBin = foldr ((:) . cond (=='0') (const '1') (const '0')) ""

p1 :: IO ()
p1 = input >>= print . uncurry (*) . (toInt &&& toInt . invertBin) . fmap mostCommon . transpose where
  mostCommon = cond (uncurry (<)) (const '1') (const '0') . (are '0' &&& are '1')
  are b = length . filter (==b)


p2 :: IO ()
p2 = input >>= print 
