
module ForeignOptions where

import Data.Foreign.Options
import Data.Maybe
import Data.Either
import Debug.Trace
import Control.Monad.Eff
import Data.Function

purescriptOptions = 
  { stringOpt : "myStringOption" -- this field will be included
  , optionalOpt1 : Just "optionalString" -- included 
  , optionalOpt2 : Just (\a b c -> 1) -- included
  , optionalOpt3 : Nothing -- field excluded
  , objectOpt : { object1 : "object1" , object2: Nothing} -- object1 field included, object2 field excluded
  , eitherOpt1 : Left "eitherOpt1" -- field included
  , eitherOpt2 : Right "eitherOpt2" -- field included
  }

foreign import stringify "function stringify(a) { return function() {console.log(a); return {}; };}"
 :: forall r a. a -> Eff (trace :: Trace | r) Unit

main = do
  print $ "conversion start"
  let forOpts = toOptions purescriptOptions
  stringify forOpts
  print $ "conversion complete"
