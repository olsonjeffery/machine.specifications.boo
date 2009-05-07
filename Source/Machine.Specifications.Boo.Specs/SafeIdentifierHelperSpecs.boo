namespace Machine.Specifications.Boo.Specs

import System
import Machine.Specifications
import Machine.Specifications.Boo
import Machine.Specifications.NUnitShouldExtensionMethods from Machine.Specifications.NUnit

when "the safe identifier helper is processing a string with puncuation":  
  it "should remove the puncuation from the string":
    result = SafeIdentifierHelper().ToBoxcarCase("hello, world")
    result.ShouldNotContain(",")

public class SafeIdentifierHelperSpecs:
"""Description of SafeIdentifierHelperSpecs"""
  public def constructor():
    pass