namespace Machine.Specifications.Boo

import System
import System.Text.RegularExpressions

public class SafeIdentifierHelper:
  public def constructor():
    pass
  
  public def ToPascalCase(input as string) as string:
    input = ReplaceOperatorsWithEnglish(input)
    input = @/ ([a-z])/.Replace(input, 
      { m as Match |
        return m.Groups[1].Value.Trim().ToUpper()
      }
  	)
    input = @/[^_a-zA-Z0-9]/.Replace(input, string.Empty)
    if /^[^_a-zA-Z]/.IsMatch(input):
      input = "_" + input
    
    return input
  
  public def ReplaceOperatorsWithEnglish(message as string) as string:
    operators = [ 
          ("==" , "equal"),
          ("!=" , "not equal"),
          (">=" , "greater than or equal"),
          ("<=" , "less than or equal"),
          ("<"  , "less than"),
          (">"  , "greater than")
          ]
    for op as (string) in operators:
      message = message.Replace(op[0], op[1])
      
    return message