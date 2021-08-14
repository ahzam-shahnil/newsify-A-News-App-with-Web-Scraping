import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  visualDensity: VisualDensity(vertical: 0.5, horizontal: 0.5),
  primarySwatch: MaterialColor(
    0xFFFAF9FE,
    <int, Color>{
      50: const Color(0xffe1e0e5), //10%
      100: const Color(0xffc8c7cb), //20%
      200: const Color(0xffafaeb2), //30%
      300: const Color(0xff969598), //40%
      400: const Color(0xff7d7d7f), //50%
      500: const Color(0xff646466), //60%
      600: const Color(0xff4b4b4c), //70%
      700: const Color(0xff323233), //80%
      800: const Color(0xff191919), //90%
      900: const Color(0xff000000), //
    },
  ),
  primaryColor: Color(0xfffbfaff),
  primaryColorBrightness: Brightness.light,
  primaryColorLight: Color(0xffb0b5b3),
  primaryColorDark: Colors.blue,
  canvasColor: Color(0xfff0efeb),
  accentColor: Color(0xff457BE0),
  accentColorBrightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xffe9ecef),
  appBarTheme: AppBarTheme(backgroundColor: Color(0xffe9ecef)),

  cardColor: Color(0xffedf2f4),
  dividerColor: Color(0xffced4da),
  focusColor: Color(0x1aF5E0C3),
  hoverColor: Color(0xffDEC29B),
  highlightColor: Color(0xffd8e2dc),
  splashColor: Color(0xff457BE0),
//  splashFactory: # override create method from  InteractiveInkFeatureFactory
  selectedRowColor: Colors.grey,
  unselectedWidgetColor: Colors.grey.shade400,
  disabledColor: Colors.grey.shade200,
  buttonTheme: ButtonThemeData(buttonColor: Colors.red),
  toggleButtonsTheme: ToggleButtonsThemeData(
      //toggle button theme
      ),
  buttonColor: Color(0xff4f5d75),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
    backgroundColor: Colors.green,
  )),
  secondaryHeaderColor: Colors.grey,
  backgroundColor: Color(0xff457BE0),
  dialogBackgroundColor: Colors.white,
  indicatorColor: Color(0xff457BE0),
  hintColor: Colors.grey,
  errorColor: Colors.red,
  toggleableActiveColor: Color(0xff6D42CE),
  textTheme: TextTheme(
      //text themes that contrast with card and canvas
      ),
  primaryTextTheme: TextTheme(headline4: TextStyle(color: Colors.blue)),
  accentTextTheme: TextTheme(
      //text theme that contrast with accent Color
      ),
  inputDecorationTheme: InputDecorationTheme(
      // default values for InputDecorator, TextField, and TextFormField
      ),
  iconTheme: IconThemeData(
      //icon themes that contrast with card and canvas
      ),
  primaryIconTheme: IconThemeData(
      //icon themes that contrast primary color
      ),
  accentIconTheme: IconThemeData(
      //icon themes that contrast accent color
      ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Color(0xff936F3E),
    selectionColor: Color(0xffB5BFD3),
    selectionHandleColor: Color(0xff936F3E),
  ),
);
