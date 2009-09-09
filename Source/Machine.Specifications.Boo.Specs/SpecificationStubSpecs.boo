namespace Machine.Specifications.Boo.Specs

import System
import Msb
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import System.Linq.Enumerable from System.Core

when a_specification_has_no_body:
  establish:
    whenMacro = WhenMacro()
    whenMacro.ModuleHandler = TestModuleHandler()
    parameters = CompilerParameters()
    parameters.Pipeline = CompilerPipeline()
    whenMacro.ParametersWrapper = parameters
    macro = MacroStatement()
    macro.Arguments.Add([| "when context name" |])
    
    macro.Body.Statements.Add([|
      it "should blah blah"
    |])
    
  because_of:
    contextClassDef = whenMacro.ExpandGeneratorImpl(macro).ToList()[0]
  
  it "should have show this spec as being not implemented"
  
  IsAnIt = def(x as TypeMember):
    x.GetType().Equals(typeof(It))
  
  macro as MacroStatement
  whenMacro as WhenMacro
  contextClassDef as ClassDefinition  