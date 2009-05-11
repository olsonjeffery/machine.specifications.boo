namespace Foo

import System
import Machine.Specifications.Boo
import Machine.Specifications.NUnitShouldExtensionMethods from Machine.Specifications.NUnit
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import Boo.Lang.Compiler.IO
import Boo.Lang.Compiler.Pipelines

when "having imported MSpec.Boo and calling an MSpec extension method", AutoImportSpecs:
  establish:
    code = """
import Machine.Specifications.Boo

when "making calls to a C# 3.0 extension method":
  it "should not barf":
    1.ShouldEqual(1)
"""
    context = CompileCodeAndGetContext(code)
  
  it "should auto-import the mspec should extension methods and compile the code successfully":
    context.Errors.Count.ShouldEqual(0)
  
  context as CompilerContext

public class AutoImportSpecs:
  
  protected static code as string
  
  protected static def CompileCodeAndGetContext(code as string) as CompilerContext:
    booC = BooCompiler()
    booC.Parameters.Input.Add(StringInput("name",code))
    for i in AppDomain.CurrentDomain.GetAssemblies():
      booC.Parameters.AddAssembly(i)
    booC.Parameters.Pipeline = CompileToMemory()
    booC.Parameters.Ducky = false
    compileContext = booC.Run()
    raise join(e for e in compileContext.Errors, "\n") if compileContext.GeneratedAssembly is null
    
    return compileContext
  
  protected static def GetTypeFromAssemblyNamed(assembly as Assembly, typeName as string) as Type:
    return assembly.GetType(typeName, true, true)
