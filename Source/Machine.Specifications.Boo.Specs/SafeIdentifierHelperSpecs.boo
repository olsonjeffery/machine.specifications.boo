namespace Machine.Specifications.Boo.Specs

import System
import Machine.Specifications
import Machine.Specifications.Boo
import Machine.Specifications.NUnitShouldExtensionMethods from Machine.Specifications.NUnit

when "the safe identifier helper is processing a class name":  
  it "should do something":
    bar.ShouldEqual(1)
  
  bar as int = 1

public class SafeIdentifierHelperSpecs:
"""Description of SafeIdentifierHelperSpecs"""
  public def constructor():
    pass