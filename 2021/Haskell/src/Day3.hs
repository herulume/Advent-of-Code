module Day3
  ( p1
  , p2
  ) where

import Cp hiding (p1, p2)
import Data.List (transpose)

input :: IO [String]
input = lines <$> readFile "day3.txt"

toInt :: String -> Int
toInt = foldl (\acc bit -> acc*2 + (read [bit])) 0

invertBin :: String -> String
invertBin = foldr ((:) . invertBit) ""

invertBit :: Char -> Char
invertBit '0' = '1'
invertBit '1' = '0'

p1 :: IO ()
p1 = input >>= print . uncurry (*) . split toInt (toInt . invertBin) . fmap mostCommon . transpose where
  mostCommon = cond (uncurry (<)) (const '1') (const '0') . split (are '0') (are '1')
  are b = length . filter (==b)

data BTree = Empty | Leaf String | Node (Maybe BTree) (Maybe BTree) deriving Show

inBTree :: Either () (Either String ((Maybe BTree), (Maybe BTree))) -> BTree 
inBTree = either (const Empty) (either Leaf (uncurry Node))

outBTree :: BTree -> Either () (Either String ((Maybe BTree),(Maybe BTree)))
outBTree Empty = Left ()
outBTree (Leaf s) = Right . Left $ s
outBTree (Node l r) = Right . Right $ (l, r)

baseBTree g f = id -|- (g -|- (fmap f >< fmap f))
recBTree f = baseBTree id f
cataBTree g = g . (recBTree (cataBTree g)) . outBTree
anaBTree f = inBTree . (recBTree (anaBTree f) ) . f
hyloBTree f g = cataBTree f . anaBTree g

coalg [] = i1 ()
coalg [d] = i2 . i1 $ d
coalg l@(_:_) = i2 . i2 . foldl build (Just [], Just []) $ l where
  build acc [] = acc
  build (zeroes, ones) ('0':ds) = (fmap (ds :) zeroes, ones)
  build (zeroes, ones) ('1':ds) = (zeroes, fmap (ds :) ones)

alg (Left _) = (0, ("", ""))
alg (Right (Left ds)) = (1, (ds, ds))
alg (Right (Right (zs, os))) = (numZero + numOne, (keep fst o2, keep snd (invertBit o2))) where
  numZero = maybe 0 fst zs
  numOne = maybe 0 fst os
  o2 = if numZero > numOne then '0' else '1'
  
  keep select '0' = '0' : foldMap (select . snd) zs
  keep select '1' = '1' : foldMap (select . snd) os
  
p2 :: IO ()
p2 = input >>= print . uncurry (*) . (toInt >< toInt) . snd . hyloBTree alg coalg
