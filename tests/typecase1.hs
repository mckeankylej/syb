{-# OPTIONS -fglasgow-exts #-}

{-

This test demonstrates type case as it lives in Data.Typeable.
We define a function f that converts typeables into strings in some way.
Note: we only need Data.Typeable. Say: Dynamics are NOT involved.

-}

import Data.Typeable
import Data.Maybe

-- Some datatype.
data MyTypeable = MyCons String deriving (Show, Typeable)

--
-- Some function that performs type case.
--
f :: (Show a, Typeable a) => a -> String
f a = (maybe (maybe (maybe others 
      		mytys (cast a) )
      		float (cast a) )
      		int   (cast a) )

 where

  -- do something with ints
  int :: Int -> String
  int a =  "got an int, incremented: " ++ show (a + 1)
  
  -- do something with floats
  float :: Float -> String
  float a = "got a float, multiplied by .42: " ++ show (a * 0.42)

  -- do something with my typeables
  mytys :: MyTypeable -> String
  mytys a = "got a term: " ++ show a

  -- do something with all other typeables
  others = "got something else: " ++ show a


--
-- Test the type case
--
main = do 
          putStrLn $ f (41::Int)
          putStrLn $ f (88::Float)
          putStrLn $ f (MyCons "42")
          putStrLn $ f True
