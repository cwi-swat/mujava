module lang::flybytes::demo::protol::Syntax

// PROTOL is a demo language, featuring object-oriented language features
// and a dynamic type system based on object and array prototypes with the missing_method
// and missing_field features. There are no classes on protol, just objects used as templates
// for other objects.

start syntax Program = Command* commands;

syntax Command 
  = assign: Assignable assign "=" Expr val ";"
  | \if: "if" "(" Expr cond ")"  "{" Command* thenPart "}" "else" "{" Command* elsePart "}"
  | \for: "while" "(" Expr cond ")" "{" Command* body "}" 
  | exp: Expr e ";"
  | \return: "return" Expr e ";" 
  | print: "print" Expr e ";"
  ;

syntax Assignable
  = var: Id name
  | field: Expr obj "." Id name
  | array: Expr array "[" Expr index "]"
  ;
    
syntax Expr
  = "this"
  | send: Expr receiver "." Id name "(" {Expr ","}* args ")"
  | array: "[" {Expr ","}* "]"
  | new: "new" Expr? prototype
  | \extend: "new" Expr? prototype "{" Definition* definitions "}" 
  | bracket "(" Expr ")"
  | ref: Id id
  | \int: Int
  | \str: String
  | field: Expr receiver "." Id name
  > array: Expr array "[" Expr index "]"
  > left  Expr "\<\<" Expr
  > left  (Expr "*" Expr | Expr "/" Expr)
  > left  (Expr "+" Expr | Expr "-" Expr )
  > right (Expr "==" Expr | Expr "!=" Expr)
  > right (Expr "\<=" Expr | Expr "\<" Expr | Expr "\>" Expr | Expr "\>=" Expr)
  ; 

syntax Definition
  = field:   Id name \ "missing" "=" Expr val
  | method:  Id name \ "missing" "(" {Id ","}* args ")" "{" Command* commands "}"
  | missing: "missing" "(" Id name "," Id args ")" "{" Command* commands "}"
  ;  
   
lexical Id     = ([A-Za-z][a-zA-Z0-9]*) \ "if" \ "new" \ "else" \ "while"  \ "return" \ "this";  
lexical Int    = [0-9]+;
lexical String = "\"" ![\"]* "\"";

layout WSC = (WS | COMM)* !>> "//" !>> [\t\n\r\ ];

lexical WS = [\t\n\r\ ]+ !>> [\t\n\r\ ];
lexical COMM = "//" ![\n]* "\n";