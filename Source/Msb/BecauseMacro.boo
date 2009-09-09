namespace Msb

import System
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast

macro because:
  body = because.Body
  yield DeclarationStatement(Declaration("of_", [| typeof(Machine.Specifications.Because) |].Type), [| { $body } |])