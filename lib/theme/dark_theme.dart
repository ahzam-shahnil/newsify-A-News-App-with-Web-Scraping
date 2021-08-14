import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  visualDensity: VisualDensity(vertical: 0.5, horizontal: 0.5),
  primarySwatch: MaterialColor(
    0xFFF5E0C3,
    <int, Color>{
      50: Color(0x1a5D4524),
      100: Color(0xa15D4524),
      200: Color(0xaa5D4524),
      300: Color(0xaf5D4524),
      400: Color(0x1a483112),
      500: Color(0xa1483112),
      600: Color(0xaa483112),
      700: Color(0xff483112),
      800: Color(0xaf2F1E06),
      900: Color(0xff2F1E06)
    },
  ),
  primaryColor: Color(0xff5D4524),
  primaryColorBrightness: Brightness.dark,
  primaryColorLight: Color(0x1a311F06),
  primaryColorDark: Color(0xff936F3E),
  canvasColor: Color(0xffE09E45),
  accentColor: Color(0xff457BE0),
  accentColorBrightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xffB5BFD3),
  bottomAppBarColor: Color(0xff6D42CE),
  cardColor: Color(0xaa311F06),
  dividerColor: Color(0x1f6D42CE),
  focusColor: Color(0x1a311F06),
  hoverColor: Color(0xa15D4524),
  highlightColor: Color(0xaf2F1E06),
  splashColor: Color(0xff457BE0),
//  splashFactory: # override create method from  InteractiveInkFeatureFactory
  selectedRowColor: Colors.grey,
  unselectedWidgetColor: Colors.grey.shade400,
  disabledColor: Colors.grey.shade200,
  buttonTheme: ButtonThemeData(
//button themes
      ),
  toggleButtonsTheme: ToggleButtonsThemeData(
//toggle button theme
      ),
  buttonColor: Color(0xff483112),
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
  primaryTextTheme: TextTheme(
//text theme that contrast with primary color
      ),
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
    cursorColor: Color(0xff483112),
    selectionColor: Color(0x1a483112),
    selectionHandleColor: Color(0xff483112),
  ),
);
