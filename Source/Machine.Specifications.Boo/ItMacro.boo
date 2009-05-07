namespace Machine.Specifications.Boo

import System
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import Boo.Lang.PatternMatching

macro it(methodName as string):
  helper = SafeIdentifierHelper()
  
  itName = "It_" + helper.ToPascalCase(methodName)
  body = it.Body
  yield DeclarationStatement(Declaration(itName, [| typeof(It) |].Type), [| { $body } |])