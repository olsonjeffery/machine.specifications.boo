namespace Machine.Specifications.Boo

import System
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast
import Boo.Lang.PatternMatching

public class WhenMacro(LexicalInfoPreservingGeneratorMacro):
  
  public override def ExpandGeneratorImpl(macro as MacroStatement) as Node*:
    raise "Only a string or safe identifier name is allowed for names of 'when/context' blocks.. ex: 'when \"foo\"' or 'when foo'  " if not macro.Arguments[0] isa ReferenceExpression and not macro.Arguments[0] isa StringLiteralExpression
    raise "Only a safe identifier name is valid as the second argument to a when block. ex: 'when \"foo\", bar' or 'when foo, bar'" if macro.Arguments.Count > 1 and not macro.Arguments[1] isa ReferenceExpression
    raise "Only one or two arguments is allowed to a when/context block.. ex: 'when foo, bar' or 'when \"foo\"'" if macro.Arguments.Count > 2 or macro.Arguments.Count == 0
    
    className as string
    className = macro.Arguments[0].ToCodeString()
    helper = SafeIdentifierHelper()
    fieldBuilder = FieldBuilder()
    
    className = helper.ToBoxcarCase(className)
    className = "when_" + className if not className.ToLower().StartsWith("when");
    classDef = [|
      public class $(ReferenceExpression(className)):
        pass
    |]

    
    for i as Statement in macro.Body.Statements:
      if i isa DeclarationStatement:
        statement as DeclarationStatement = i
        field = fieldBuilder.BuildProtectedStaticFieldFromDeclarationStatement(statement)
        classDef.Members.Add(field)
    
    yield classDef