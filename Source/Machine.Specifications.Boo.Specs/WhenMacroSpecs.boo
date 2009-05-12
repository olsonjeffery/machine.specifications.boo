namespace Machine.Specifications.Boo.Specs

import System
import Msb
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import System.Linq.Enumerable from System.Core

when a_context_has_a_reference_identifier_for_its_name:
  establish:
    whenMacro = WhenMacro()
    whenMacro.ModuleHandler = TestModuleHandler()
    parameters = CompilerParameters()
    parameters.Pipeline = CompilerPipeline()
    whenMacro.ParametersWrapper = parameters
    macro = MacroStatement()
    macro.Arguments.Add([| context_name |])
    
  because_of:
    contextClassDef = whenMacro.ExpandGeneratorImpl(macro).ToList()[0]
    
  it "should use the provided identifier with the word when prepended as the class' name":
    contextClassDef.Name.ShouldEqual("when_context_name")
  
  macro as MacroStatement
  whenMacro as WhenMacro
  contextClassDef as ClassDefinition

when "a context has a string for it's name":
  establish:
    whenMacro = WhenMacro()
    whenMacro.ModuleHandler = TestModuleHandler()
    parameters = CompilerParameters()
    parameters.Pipeline = CompilerPipeline()
    whenMacro.ParametersWrapper = parameters
    macro = MacroStatement()
    macro.Arguments.Add([| "context name" |])
    
  because_of:
    contextClassDef = whenMacro.ExpandGeneratorImpl(macro).ToList()[0]
    
  it "should convert the string to a boxcar reference identifier":
    contextClassDef.Name.ShouldEqual("when_context_name")
  
  macro as MacroStatement
  whenMacro as WhenMacro
  contextClassDef as ClassDefinition

when "a context's name starts with the word 'when'":
  establish:
    whenMacro = WhenMacro()
    whenMacro.ModuleHandler = TestModuleHandler()
    parameters = CompilerParameters()
    parameters.Pipeline = CompilerPipeline()
    whenMacro.ParametersWrapper = parameters
    macro = MacroStatement()
    macro.Arguments.Add([| "when context name" |])
    
  because_of:
    contextClassDef = whenMacro.ExpandGeneratorImpl(macro).ToList()[0]
    
  it "should not attempt to prepend 'when' and an underscore to the context's name":
    contextClassDef.Name.ShouldEqual("when_context_name")
  
  macro as MacroStatement
  whenMacro as WhenMacro
  contextClassDef as ClassDefinition  