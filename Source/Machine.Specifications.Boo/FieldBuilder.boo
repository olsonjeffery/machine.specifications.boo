namespace Machine.Specifications.Boo

import System
import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast

public class FieldBuilder:
  public def constructor():
    pass
  
  public def BuildProtectedStaticFieldFromDeclarationStatement(declaration as DeclarationStatement) as Field:
    name = declaration.Declaration.Name
    type = declaration.Declaration.Type.CloneNode()
    
    tempClass as ClassDefinition
    if not type.ToCodeString() in ("Machine.Specifications.Establish", "Machine.Specifications.Cleanup", "Machine.Specifications.Because", "Machine.Specifications.It"):
      tempClass = [|
        public class foo:
          protected static $(ReferenceExpression(name)) as $type
      |]
    else:
      tempClass = [|
        public class foo:
          protected $(ReferenceExpression(name)) as $type
      |]
    field = tempClass.Members[0] as Field
    field.Initializer = declaration.Initializer.CloneNode() if declaration.Initializer is not null
    return field