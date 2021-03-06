## Strings & Numbers

### Strings

1. String interpolation - the process of dynamically integrating values into a String.
    - the string must be enclosed within double quotes, and the variables appear within '#{}'

```Ruby
  p "The quick brown #{animal} jumped over the lazy #{noun}"
```

2. Methods with similar names, the only difference being a bang! at the end - the ! version changes the original value stored in the variable.

3. #sub vs #gsub - #sub replaces the first match found in a string, #gsub replaces all matches(global substitution)

4. #strip vs #chomp - #chomp strips white space chars from the ends osf a string, #strip removes them from the front and end of a string


### Numbers

1. In mathematics and CS the order of arithmetic operations follows operator precedence, e.g exponents are calculated before multiplication/division which is calculated before addition/subtraction.
  - an easy way to remember this is with the PEMDAS acronym:
    * Parenthesis
    * Exponents
    * Multiplication
    * Division
    * Addition
    * Subtraction

2. Ruby provides a number of classes for handling numbers.
    * Numeric which is the parent, top-level class
    * Integer class which handles whole numbers and is the basis of the Fixnum and Bignum classes (Bignum - any integer that exceeds Fixnum range is automatically converted to Bignum)
    * Float class which represents numbers with a decimal or floating point - are inexact numbers. For more precession or for very large numbers, such as in financial calculations use the BigDecimal class.
