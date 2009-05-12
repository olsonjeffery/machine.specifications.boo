namespace Machine.Specifications.Boo.Specs

import System
import Msb

when "processing a context or specification name with puncuation":  
  establish:
    input = "hello, world"
  
  because_of:
    result = SafeIdentifierHelper().ToBoxcarCase(input)
  
  it "should remove the puncuation from the string":
    result.ShouldNotContain(",")
  
  input as string
  result as string
  
when "processing a context or specification name with spaces":
  establish:
    input = "hello world"
  
  because_of:
    result = SafeIdentifierHelper().ToBoxcarCase(input)
  
  it "should replace the spaces with underscores":
    result.ShouldEqual("hello_world")
  
  input as string
  result as string