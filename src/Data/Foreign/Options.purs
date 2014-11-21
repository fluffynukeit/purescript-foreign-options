
module Data.Foreign.Options 
  ( Options()
  , OptionsSrc(..)
  , toOptions
  ) 
where

import Data.Either
import Data.Maybe
import Data.Function


foreign import data Options :: * -> *
data OptionsSrc a b = OptionsSrc a b

foreign import toOptionsImpl
  "function toOptionsImpl(l, r, j, n, record) { \
  \\
  \  var applyArgs = function(f, args) { \
  \    return (args.length == 0) ? f : applyArgs(f(args.shift()), args); \
  \  }; \
  \\  
  \  var convert = function(value) { \
  \    var ctr = value.constructor; \
  \    if (ctr === l.constructor || \
  \        ctr === r.constructor || \
  \        ctr === j.constructor) { \
  \      return convert(value.value0); \
  \    } else if (value === n) { \
  \      return null; \
  \    } else if (typeof value === \"function\") { \
  \      return function() { \
  \               var argArray = [].slice.call(arguments);\
  \               return applyArgs(value, argArray); \
  \             }; \
  \    } else if (typeof value === \"object\") { \
  \      return toOptionsImpl(l, r, j, n, value); \
  \    } else { \
  \      return value; \
  \    } \
  \  }; \
  \\
  \  var optsRecord = {}; \
  \  for (var field in record) { \ 
  \    var convValue = convert(record[field]); \
  \    if (convValue != null) { \
  \      optsRecord[field] = convValue; \
  \    } \
  \  } \
  \\
  \  return optsRecord; \
  \}" :: forall a b c. Fn5 (Either b b) (Either b b) (Maybe b) (Maybe b) a c

toOptions :: forall a b. OptionsSrc a {|b} -> Options a
toOptions (OptionsSrc _ record) = 
  runFn5 toOptionsImpl (Left {}) (Right {}) (Just {}) (Nothing) record

