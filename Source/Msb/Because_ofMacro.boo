namespace Msb

import System
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast

macro because_of:
  body = because_of.Body
  yield DeclarationStatement(Declaration("of_", [| typeof(Machine.Specifications.Because) |].Type), [| { $body } |])