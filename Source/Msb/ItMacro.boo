namespace Msb

import System
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import Boo.Lang.PatternMatching

macro it(methodName as string):
  helper = SafeIdentifierHelper()
  
  itName = helper.ToBoxcarCase(methodName)
  body = (it.Body if it.Body.Statements.Count > 0 else null)
  yield DeclarationStatement(Declaration(itName, [| typeof(Machine.Specifications.It) |].Type), ([| { $body } |] if body is not null else body))