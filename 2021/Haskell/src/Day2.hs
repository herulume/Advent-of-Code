module Day2
  ( p1
  , p2
  ) where

import Data.Char (toUpper)

data Command = Forward Int | Up Int | Down Int deriving Read
data Position = Pos { horizontal :: Int
                    , depth :: Int
                    } deriving Show
data PosAim = PosAim { pos :: Position
                     , aim :: Int
                     }

input :: IO [Command]
input = (fmap parse . lines) <$> readFile "day2.txt" where
  parse = read . (((:) . toUpper . head) <*> tail)


alg :: Position -> Command -> Position
alg p@(Pos { horizontal = h }) (Forward n) = p { horizontal = h + n }
alg p@(Pos { depth = d }) (Up n) = p { depth = d - n }
alg p@(Pos { depth = d }) (Down n) = p { depth = d + n }

alg2 :: PosAim -> Command -> PosAim
alg2 (PosAim (Pos h d) a) (Forward n) = PosAim (Pos (h + n) (d + n * a)) a
alg2 (PosAim p a) (Up n) = PosAim p (a - n)
alg2 (PosAim p a) (Down n) = PosAim p (a + n)

p1 :: IO ()
p1 = input >>= print . (\(Pos h d) -> h * d)  . foldl alg (Pos 0 0)

p2 :: IO ()
p2 = input >>= print . (\(PosAim (Pos h d) _) -> h * d)  . foldl alg2 (PosAim (Pos 0 0) 0)
