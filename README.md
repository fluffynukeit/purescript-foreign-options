purescript-foreign-options
==========================

Purescript module for converting options objects defined in Purescript into objects used for options in foreign Javascript libraries.

### Motivation

Many Javascript libraries use anonymous objects to specify "options" for configuring various
operations.  Often, the option fields can take one of a couple types (such either
`String` or `Number`) or can be absent from the object entirely, in which case
a reasonable default is assumed.

In Purescript, this kind of behavior can be modeled with the `Either` type in 
the first case and the `Maybe` type in the second.  However, because the
Javascript library does not understand these types, a conversion must be made
before the options can be used in the foreign library.  This module provides functionality for
handling this conversion in a type safe way.

The module declares two types: `OptionsSrc` and `Options`.  `OptionsSrc`
associates an options type `a` with a Purescript record of options type `{|b}`  The `toOptions` function
then converts any `OptionsSrc a {|b}` to a foreign object `Options a`.  The
foreign function can then be declared to accept a specify kind of foreign options,
such as `Options MyLibrary`, so passing options of the wrong type to a foreign
function results in a compile time error.

### Conversion method

 This function converts an arbitrary record in the following ways:

1. `Left` and `Right` are converted to the conversion of their inner values.
2. `Just` is converted to the conversion of its inner value.
3. Fields with `Nothing` are not included in the resulting options object.
4. Fields with records are kept and their value is the conversion of the record.
5. Anything else is left unchanged and must be manually converted to one of the
above types or the type expected by the Javascript library before invoking `toOptions`.



