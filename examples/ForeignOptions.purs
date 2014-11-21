
module ForeignOptions where

import Data.Foreign.Options
import Data.Maybe
import Data.Either
import Debug.Trace
import Control.Monad.Eff
import Data.Function

-- Phantom type to keep track of what kind of Options are generated, so using
-- the wrong kind of Options is a compile error.  This way, functions can
-- be declared to accept only the foreign options of the correct type.
data TestOptions = TestOptions 

myTestOptions = OptionsSrc TestOptions
  { stringOpt : "myStringOption" -- this field will be included
  , optionalOpt1 : Just "optionalString" -- included 
  , optionalOpt2 : Just (\a b c -> 1) -- included
  , optionalOpt3 : Nothing -- field excluded
  , objectOpt : { object1 : "object1" , object2: Nothing} -- object1 field included, object2 field excluded
  , eitherOpt1 : Left "eitherOpt1" -- field included
  , eitherOpt2 : Right "eitherOpt2" -- field included
  }

-- This stringify method is declared to only accept Options with the TestOptions
-- phantom type.  Using Options 
foreign import stringify "function stringify(a) { return function() {console.log(a); return {}; };}"
 :: forall r. Options TestOptions -> Eff (trace :: Trace | r) Unit

main = do
  print $ "conversion start"
  let forOpts = toOptions myTestOptions
  -- Here, type of forOpts is Options TestOptions
  stringify forOpts
  print $ "conversion complete"
