
module ForeignOptions where

import Data.Foreign.Options
import Data.Maybe
import Data.Either
import Debug.Trace
import Control.Monad.Eff
import Data.Function


type TestOptions = 
  { stringOpt     :: String
  , optionalOpt1  :: Maybe String
  , optionalOpt2  :: Maybe (String -> Number -> {whatever :: Boolean} -> Number)
  , optionalOpt3  :: Maybe String
  , objectOpt     :: { object1 :: String, object2:: Maybe String}
  , eitherOpt1    :: Either String Number
  , eitherOpt2    :: Either Number String
  }

defaultOpts = 
  { stringOpt : "myStringOption" -- this field will be included
  , optionalOpt1 : Just "optionalString" -- included 
  , optionalOpt2 : Just (\a b c -> 1) -- included
  , optionalOpt3 : Nothing -- field excluded
  , objectOpt : { object1 : "object1" , object2: Nothing} -- object1 field included, object2 field excluded
  , eitherOpt1 : Left "eitherOpt1" -- field included
  , eitherOpt2 : Right "eitherOpt2" -- field included
  } :: TestOptions

-- This stringify method is declared to only accept Options with the TestOptions
-- phantom type.  Using Options 
foreign import stringify "function stringify(a) { return function() {console.log(a); return {}; };}"
 :: forall r. Options TestOptions -> Eff (trace :: Trace | r) Unit

main = do
  print $ "conversion start"
  let forOpts = toOptions defaultOpts

  -- Here, type of forOpts is Options TestOptions
  stringify forOpts
  print $ "conversion complete"

  -- We can also selectively update options using record syntax
  print $ "updated conversion start"
  stringify <<< toOptions $ defaultOpts { optionalOpt3 = Just "new opt 3" }
  print $ "updated conversion complete"

  -- Using the wrong record type (such as incomplete record) is a compile error:
  -- print $ "compile error start"
  -- stringify <<< toOptions $ { stringOpt : "my wrong option" }
  -- print $ "compile error end"

  
  
