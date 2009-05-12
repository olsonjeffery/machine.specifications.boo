namespace Msb

import System
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast

macro cleanup:
  body = cleanup.Body
  yield DeclarationStatement(Declaration("after_", [| typeof(Machine.Specifications.Cleanup) |].Type), [| { $body } |])