
module Data.Foreign.Options 
  ( Options()
  , toOptions
  ) 
where

import Data.Either
import Data.Maybe
import Data.Function


foreign import data Options :: *

foreign import toOptionsImpl
  "function toOptionsImpl(record) { \
  \\
  \  var applyArgs = function(f, args) { \
  \    return (args.length == 0) ? f : applyArgs(f(args.shift()), args); \
  \  }; \
  \\  
  \  var convert = function(value) { \
  \\
  \    if (value instanceof PS.Data_Either.Left || \
  \        value instanceof PS.Data_Either.Right || \
  \        value instanceof PS.Data_Maybe.Just) { \
  \      return convert(value.value0); \
  \    } else if (value instanceof PS.Data_Maybe.Nothing) { \
  \      return null; \
  \    } else if (typeof value === \"function\") { \
  \      return function() { \
  \               var argArray = [].slice.call(arguments);\
  \               return applyArgs(value, argArray); \
  \             }; \
  \    } else if (typeof value === \"object\") { \
  \      return toOptionsImpl(value); \
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
  \}" :: forall a b. Fn1 a b

toOptions :: forall a. {|a} -> Options
toOptions = runFn1 toOptionsImpl

