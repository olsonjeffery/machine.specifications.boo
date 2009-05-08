namespace Machine.Specifications.Boo

import System
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import Boo.Lang.PatternMatching

macro it(methodName as string):
  helper = SafeIdentifierHelper()
  
  itName = helper.ToBoxcarCase(methodName)
  body = it.Body
  yield DeclarationStatement(Declaration(itName, [| typeof(Machine.Specifications.It) |].Type), [| { $body } |])