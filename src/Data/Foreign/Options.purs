module Data.Foreign.Options 
  ( Options()
  , Opaque(..)
  , toOptions
  ) 
where

import Data.Either (Either(..))
import Data.Maybe (Maybe(..)) 
import Data.Function (Fn6, runFn6)

foreign import data Options :: * -> *
data Opaque a = Opaque a

foreign import toOptionsImpl :: forall a b c.  
     Fn6 (Either b b) (Either b b) (Maybe b) (Maybe b) (Opaque b) a c

toOptions :: forall a. {|a} -> Options {|a}
toOptions record = 
  runFn6 toOptionsImpl 
    (Left {}) 
    (Right {}) 
    (Just {}) 
    (Nothing) 
    (Opaque {}) 
    record

