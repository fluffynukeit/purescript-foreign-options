purescript-foreign-options
==========================

Purescript module for converting options records defined in Purescript into 
objects used for options in foreign Javascript libraries.

### Motivation

Many Javascript libraries use anonymous objects to specify "options" for configuring various
operations.  Often, the option fields can take one of a couple types (such as either
`String` or `Number`) or can be absent from the object entirely, in which case
a reasonable default is assumed.

In Purescript, this kind of behavior can be modeled with the `Either` type in 
the first case and the `Maybe` type in the second.  However, because the
Javascript library does not understand these types, a conversion must be made
before the options can be used in the foreign library.  This module provides functionality for
handling this conversion in a type safe way.

### Functionality

The module defines a type `Options a` to represent a foreign anonymous options
object.  Also defined is a function `toOptions` that converts a purescript record
of type `{|a}` to `Options {|a}`.  In this way, foreign functions that consume the
options can be declared using `Options MyOptionsRecordType` in the function signature,
so passing any incomplete or incorrect set of options to that function is a 
compile time error.

Additionally, since records are used to respresent the set of options in Purescript,
options can be easily updated using the `record { myfield = 7 }` syntax.

The conversion is one-way; there is no provided functionality to marshal the
`Options` type back to a Purescript record.

Example usage is provided in the `examples` directory.

### Conversion method

 This function converts an arbitrary record in the following ways:

1. `Left` and `Right` are converted to the conversion of their inner values.
2. `Just` is converted to the conversion of its inner value.
3. Fields with `Nothing` are not included in the resulting options object.
4. Fields with functions returning pure values are converted to an uncurried form.
5. Fields with functions returning effectful value are converted to an uncurried form and run immediately.
6. Fields with records are kept and their value is the conversion of the record.
7. Anything else is left unchanged and must be manually converted to one of the
above types or the type expected by the Javascript library before invoking `toOptions`.



