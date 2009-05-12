namespace Machine.Specifications.Boo.Specs

import Msb
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import System.Linq.Enumerable from System.Core

when a_context_has_a_base_contexts_name_as_the_second_argument, InheritanceSpecs:
  establish:
    whenMacro = WhenMacro()
    whenMacro.ModuleHandler = TestModuleHandler()
    parameters = CompilerParameters()
    parameters.Pipeline = CompilerPipeline()
    whenMacro.ParametersWrapper = parameters
    macro = MacroStatement()
    macro.Arguments.Add([| context_name |])
    macro.Arguments.Add([| base_context |])
    
  because_of:
    contextClassDef = whenMacro.ExpandGeneratorImpl(macro).ToList()[0]
    
  it "set the context's base class as being the base context":
    contextClassDef.BaseTypes[0].ToString().ShouldEqual([| typeof(base_context) |].Type.ToString())
  
  macro as MacroStatement
  whenMacro as WhenMacro
  contextClassDef as ClassDefinition


public class InheritanceSpecs:
"""Description of InheritanceSpecs"""
  public def constructor():
    pass

