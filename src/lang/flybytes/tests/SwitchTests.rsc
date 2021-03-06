module lang::flybytes::tests::SwitchTests

import lang::flybytes::Syntax;
import lang::flybytes::Compiler;
import Node;

Class switchClass(SwitchOption option) 
  = class(object("SwitchClass_<getName(option)>"),
      methods=[
        staticMethod(\public(), integer(), "testMethod", [var(integer(), "par")],
        [ 
          \switch(load("par"), [
            \case(42, [
              \return(iconst(42))
            ]),
            \case(12, [
              \return(iconst(12))
            ])
          ],option=option),
          \return(iconst(0))          
        ])
      ]
    );
    
bool testSwitchClass(Class c, int input, int result) { 
  m = loadClass(c, file=just(|project://flybytes/generated/<c.\type.name>.class|));
  return m.invokeStatic(methodDesc(boolean(), "testMethod", [integer()]), [integer(input)]).toValue(#int) == result;
} 

test bool simpleSwitch1table() = testSwitchClass(switchClass(table()), 42, 42);
test bool simpleSwitch2table() = testSwitchClass(switchClass(table()), 12, 12);
test bool simpleSwitch3table() = testSwitchClass(switchClass(table()), 18, 0);

test bool simpleSwitch1lookup() = testSwitchClass(switchClass(lookup()), 42, 42);
test bool simpleSwitch2lookup() = testSwitchClass(switchClass(lookup()), 12, 12);
test bool simpleSwitch3lookup() = testSwitchClass(switchClass(lookup()), 18, 0);

test bool simpleSwitch1auto() = testSwitchClass(switchClass(auto()), 42, 42);
test bool simpleSwitch2auto() = testSwitchClass(switchClass(auto()), 12, 12);
test bool simpleSwitch3auto() = testSwitchClass(switchClass(auto()), 18, 0);


Class switchDefaultClass(SwitchOption option) 
  = class(object("SwitchDefaultClass_<getName(option)>"),
      methods=[
        staticMethod(\public(), integer(), "testMethod", [var(integer(), "par")],
        [ 
          \switch(load("par"), [
            \case(42, [
              \return(iconst(42))
            ]),
            \case(12, [
              \return(iconst(12))
            ]),
            \default([
              \return(sub(load("par"), iconst(1)))
            ])
          ],option=option),
          \return(iconst(0))          
        ])
      ]
    );
    

test bool simpleDefaultSwitch1Table() = testSwitchClass(switchDefaultClass(table()), 42, 42);
test bool simpleDefaultSwitch2Table() = testSwitchClass(switchDefaultClass(table()), 12, 12);
test bool simpleDefaultSwitch3Table() = testSwitchClass(switchDefaultClass(table()), 0, -1);

test bool simpleDefaultSwitch1Lookup() = testSwitchClass(switchDefaultClass(lookup()), 42, 42);
test bool simpleDefaultSwitch2Lookup() = testSwitchClass(switchDefaultClass(lookup()), 12, 12);
test bool simpleDefaultSwitch3Lookup() = testSwitchClass(switchDefaultClass(lookup()), 0, -1);

test bool simpleDefaultSwitch1Auto() = testSwitchClass(switchDefaultClass(auto()), 42, 42);
test bool simpleDefaultSwitch2Auto() = testSwitchClass(switchDefaultClass(auto()), 12, 12);
test bool simpleDefaultSwitch3Auto() = testSwitchClass(switchDefaultClass(auto()), 0, -1);

Class switchCompactClass(SwitchOption option) 
  = class(object("SwitchCompactClass_<getName(option)>"),
      methods=[
        staticMethod(\public(), integer(), "testMethod", [var(integer(), "par")],
        [ 
          \switch(load("par"), [
            \case(0, [
              \return(iconst(0))
            ]),
            \case(1, [
              \return(iconst(1))
            ]),
            \case(2, [
              \return(iconst(2))
            ]),
             \case(3, [
              \return(iconst(3))
            ]),
             \case(4, [
              \return(iconst(4))
            ]),
             \case(5, [
              \return(iconst(5))
            ]),
             \case(7, [
              \return(iconst(5))
            ]),
             \case(8, [
              \return(iconst(5))
            ]),
             \case(9, [
              \return(iconst(5))
            ]),
             \case(10, [
              \return(iconst(5))
            ]),
             \case(11, [
              \return(iconst(5))
            ]),
             \case(12, [
              \return(iconst(5))
            ]),
            \default([
              \return(sub(load("par"), iconst(1)))
            ])
          ],option=option),
          \return(iconst(0))          
        ])
      ]
    );
    

test bool compactDefaultSwitch1Table() = testSwitchClass(switchCompactClass(table()), 0, 0);
test bool compactDefaultSwitch2Table() = testSwitchClass(switchCompactClass(table()), 1, 1);
test bool compactDefaultSwitch3Table() = testSwitchClass(switchCompactClass(table()), 2, 2);
test bool compactDefaultSwitch4Table() = testSwitchClass(switchCompactClass(table()), 6, 5);

test bool compactDefaultSwitch1Lookup() = testSwitchClass(switchCompactClass(lookup()),  0, 0);
test bool compactDefaultSwitch2Lookup() = testSwitchClass(switchCompactClass(lookup()),  1, 1);
test bool compactDefaultSwitch3Lookup() = testSwitchClass(switchCompactClass(lookup()),  2, 2);
test bool compactDefaultSwitch4Lookup() = testSwitchClass(switchCompactClass(lookup()),  6, 5);

test bool compactDefaultSwitch1Auto() = testSwitchClass(switchCompactClass(auto()), 0, 0);
test bool compactDefaultSwitch2Auto() = testSwitchClass(switchCompactClass(auto()), 1, 1);
test bool compactDefaultSwitch3Auto() = testSwitchClass(switchCompactClass(auto()), 2, 2);
test bool compactDefaultSwitch4Auto() = testSwitchClass(switchCompactClass(auto()), 6, 5);


