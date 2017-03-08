/* global exports */
"use strict";

// module Data.Foreign.Options 
function toOptionsImpl(l, r, j, n, o, record) { 
  
    var applyArgs = function(f, args) { 
      return (args.length == 0) ? ((typeof f === 'function') ? f() : f) : applyArgs(f(args.shift()), args); 
    }; 
     
    var convert = function(value) { 
      var ctr = value.constructor; 
      if (ctr === l.constructor || 
          ctr === r.constructor || 
          ctr === j.constructor) { 
        return convert(value.value0); 
      } else if (ctr === o.constructor) {
        return value.value0; 
      } else if (value === n) { 
        return null; 
      } else if (typeof value === 'function') { 
        return function() { 
                 var argArray = [].slice.call(arguments);
                 return applyArgs(value, argArray); 
               }; 
      } else if (typeof value === 'object') { 
        return toOptionsImpl(l, r, j, n, o, value); 
      } else { 
        return value; 
      } 
    }; 
  
    var optsRecord = {};
    for (var field in record) { 
      if (record.hasOwnProperty(field)) { 
        var convValue = convert(record[field]); 
        if (convValue != null) { 
          optsRecord[field] = convValue; 
        } 
      } 
    } 
  
    return optsRecord; 

}

exports.toOptionsImpl = toOptionsImpl;
