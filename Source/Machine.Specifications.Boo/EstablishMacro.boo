namespace Machine.Specifications.Boo

import System
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import Boo.Lang.PatternMatching

macro establish:
  body = establish.Body
  yield DeclarationStatement(Declaration("context_", [| typeof(Machine.Specifications.Establish) |].Type), [| { $body } |])