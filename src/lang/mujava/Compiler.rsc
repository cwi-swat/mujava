module lang::mujava::Compiler

extend lang::mujava::Mirror;
extend lang::mujava::Syntax;
import lang::mujava::api::Object;
import lang::mujava::api::System;
import IO;

data JDKVersion = v1_6() | v1_7() | v1_8();

@javaClass{lang.mujava.internal.ClassCompiler}
@reflect{for stdout}
@doc{compiles a mujava class to a JVM bytecode class and saves the result to the target location}
java void compileClass(Class cls, loc classFile, bool enableAsserts=false, JDKVersion version=v1_6());

@javaClass{lang.mujava.internal.ClassCompiler}
@reflect{for stdout}
@doc{compiles a mujava class to a JVM bytecode class and loads the result as a class Mirror value.}
java Mirror loadClass(Class cls, list[loc] classpath=[], bool enableAsserts=false, JDKVersion version=v1_6());

public Class helloWorld = class(classType("HelloWorld"), 
    fields =[
      field( classType("java.lang.Integer"),"age", modifiers={\public()})
    ], 
    methods=[
     defaultConstructor(\public()),
     main("args", 
        block([var(classType("HelloWorld"), "hw"), var(integer(), "i")],[
          store("hw", new("HelloWorld")),
          do(\void(), invokeVirtual("HelloWorld", load("hw"), methodDesc(\void(),"f",[array(string())]), [load("args")])),
          \return()
        ])
      ),
      
     staticMethod(\public(), \integer(), "MIN", [var(integer(),"i"),var(integer(), "j")], 
        block([],[
           \if (lt(\integer(), load("i"), load("j")),[
             \return(\integer(), load("i"))
           ],[
             \return(\integer(), load("j"))
           ])
        ])),
        
     staticMethod(\public(), \integer(), "LEN", [var(array(string()),"a")], 
        block([],[
           \return(\integer(), alength(load("a")))
        ])),   
          
     method(\public(), \void(), "f", [var(array(string()), "s")], block([var(integer(),"i"), var(long(),"j"), var(float(), "k"), var(double(), "l"), var(integer(), "m")],[
       // test storing numbers in local variables
       
       store("i", const(integer(), 245)),
       store("j", const(long(), 350000)),
       store("k", const(float(), 10.5)),
       store("l", const(double(), 3456.3456)),
       store("m", const(integer(), 244)),
       
       // test loading numbers
       do(integer(), load("i")),
       do(long(), load("j")),
       do(integer(), load("i")),
       do(float(), load("k")),
       do(double(), load("l")),
       
       // print the 3 elements of the argument list:
       \if(gt(integer(), load("i"), load("m")), [
         stdout(aaload(string(), load("s"), const(integer(), 0))),
         stdout(aaload(string(), load("s"), const(integer(), 1))),
         stdout(aaload(string(), load("s"), const(integer(), 2)))
       ]),
       
       
       //\return(long(), load("j"))
       \return()
     ]))
    ]
  );
  
void main() {
  compileClass(helloWorld, |home:///HelloWorld.class|);
}


