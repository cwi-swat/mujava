module lang::mujava::api::JavaLang

import lang::mujava::Syntax;
import lang::mujava::Mirror;

Type String() = string();
Type Boolean() = classType("java.lang.Boolean");
Type Integer() = classType("java.lang.Integer");
Type Character() = classType("java.lang.Character");
Type Double() = classType("java.lang.Double");
Type Long() = classType("java.lang.Long");
Type Short() = classType("java.lang.Short");
Type Float() = classType("java.lang.Float");

Mirror StringMirror() = classMirror("java.lang.string");
Mirror BooleanMirror() = classMirror("java.lang.Boolean");
Mirror ByteMirror() = classMirror("java.lang.Byte");
Mirror IntegerMirror() = classMirror("java.lang.Integer");
Mirror CharacterMirror() = classMirror("java.lang.Character");
Mirror DoubleMirror() = classMirror("java.lang.Double");
Mirror LongMirror() = classMirror("java.lang.Long");
Mirror ShortMirror() = classMirror("java.lang.Short");
Mirror FloatMirror() = classMirror("java.lang.Float");


real floatMax() = FloatMirror().getStatic("MAX_VALUE").toValue(#real);
real floatMin() = FloatMirror().getStatic("MIN_VALUE").toValue(#real);

real doubleMax() = DoubleMirror().getStatic("MAX_VALUE").toValue(#real);
real doubleMin() = DoubleMirror().getStatic("MIN_VALUE").toValue(#real);

int shortMax() = ShortMirror().getStatic("MAX_VALUE").toValue(#int);
int shortMin() = ShortMirror().getStatic("MIN_VALUE").toValue(#int);

int intMax() = IntegerMirror().getStatic("MAX_VALUE").toValue(#int);
int intMin() = IntegerMirror().getStatic("MIN_VALUE").toValue(#int);

int longMax() = LongMirror().getStatic("MAX_VALUE").toValue(#int);
int longMin() = LongMirror().getStatic("MIN_VALUE").toValue(#int);

int byteMax() = ByteMirror().getStatic("MAX_VALUE").toValue(#int);
int byteMin() = ByteMirror().getStatic("MIN_VALUE").toValue(#int);