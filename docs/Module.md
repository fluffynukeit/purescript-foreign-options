# Module Documentation

## Module Data.Foreign.Options

### Types

    data Opaque a where
      Opaque :: a -> Opaque a

    data Options :: * -> *


### Values

    toOptions :: forall a. {  | a } -> Options {  | a }