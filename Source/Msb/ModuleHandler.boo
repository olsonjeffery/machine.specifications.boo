namespace Msb

import System
import Boo.Lang.Compiler.Ast

public class ModuleHandler:
  
  public def constructor():
    pass
  
  public virtual def GetModuleFromNode(node as Node) as Module:
    while not node isa Module:
      node = node.ParentNode
    return node as Module