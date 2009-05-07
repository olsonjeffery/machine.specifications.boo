namespace Machine.Specifications.Boo

import System
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import Boo.Lang.PatternMatching

macro when(className as string):
  helper = SafeIdentifierHelper()
  fieldBuilder = FieldBuilder()
  
  className = "when_"+helper.ToBoxcarCase(className)
  
  classDef = [|
    public class $(ReferenceExpression(className)):
      pass
  |]
  
  for i as Statement in when.Body.Statements:
    if i isa DeclarationStatement:
      statement as DeclarationStatement = i
      field = fieldBuilder.BuildProtectedStaticFieldFromDeclarationStatement(statement)
      classDef.Members.Add(field)
  
  yield classDef