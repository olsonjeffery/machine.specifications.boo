namespace Machine.Specifications.Boo.Specs

import System
import Machine.Specifications
import Machine.Specifications.Boo
import Machine.Specifications.NUnitShouldExtensionMethods from Machine.Specifications.NUnit

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

when we_have_a_class_named_like_this:
  pass

public class SafeIdentifierHelperSpecs:
"""Description of SafeIdentifierHelperSpecs"""
  public def constructor():
    pass