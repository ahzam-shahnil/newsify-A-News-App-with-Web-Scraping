import 'package:flutter/cupertino.dart';
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
    primaryColor: Color(0xff12161B),
    primaryColorBrightness: Brightness.dark,
    primaryColorLight: Color(0x1a311F06),
    primaryColorDark: Color(0xff12161B),
    canvasColor: Color(0xff12161B),
    accentColor: Color(0xff457BE0),
    accentColorBrightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xff12161B),
    bottomAppBarColor: Color(0xff12161B),
    cardColor: Color(0xff181E25),
    dividerColor: Color(0x1f6D42CE),
    focusColor: Color(0x1a311F06),
    hoverColor: Colors.black87,
    highlightColor: Color(0xaf2F1E06),
    splashColor: Color(0xff457BE0),
//  splashFactory: # override create method from  InteractiveInkFeatureFactory
    selectedRowColor: Colors.grey,
    unselectedWidgetColor: Colors.grey.shade400,
    disabledColor: Colors.grey.shade200,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      backgroundColor: Colors.green,
    )),
    toggleButtonsTheme: ToggleButtonsThemeData(
//toggle button theme
        ),

    buttonColor: Color(0xffB5BFD3),
    secondaryHeaderColor: Color(0xff12161B),
    backgroundColor: Color(0xff457BE0),
    dialogBackgroundColor: Color(0xff181E25),
    indicatorColor: Color(0xff457BE0),
    hintColor: Colors.grey,
    errorColor: Colors.red,
    toggleableActiveColor: Color(0xff6D42CE),
    textTheme: TextTheme(),
    primaryTextTheme: TextTheme(headline4: TextStyle(color: Colors.blue)),
    accentTextTheme: TextTheme(
//text theme that contrast with accent Color
        ),
    buttonTheme: ButtonThemeData(),
    inputDecorationTheme: InputDecorationTheme(
// default values for InputDecorator, TextField, and TextFormField
        ),
    iconTheme: IconThemeData(color: Colors.green,),
    primaryIconTheme: IconThemeData(color: Colors.green),
    accentIconTheme: IconThemeData(

        ),
   
    sliderTheme: SliderThemeData(
        // slider themes
        ),
    tabBarTheme: TabBarTheme(
        // tab bat theme
        ),
    tooltipTheme: TooltipThemeData(
        // tool tip theme
        ),
    cardTheme: CardTheme(),
    platform: TargetPlatform.android,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    applyElevationOverlayColor: true,
    pageTransitionsTheme: PageTransitionsTheme(),
    appBarTheme: AppBarTheme(backgroundColor: Color(0xff12161B)),
    bottomAppBarTheme: BottomAppBarTheme(
        // bottom app bar theme
        ),
    snackBarTheme: SnackBarThemeData(
        // snack bar theme
        ),
    dialogTheme: DialogTheme(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        // floating action button theme
        ),
    navigationRailTheme: NavigationRailThemeData(
        // navigation rail theme
        ),
    typography: Typography.material2018(),
    cupertinoOverrideTheme: CupertinoThemeData(
        //cupertino theme
        ),
    bottomSheetTheme: BottomSheetThemeData(
        //bottom sheet theme
        ),
    popupMenuTheme: PopupMenuThemeData(
        //pop menu theme
        ),
    bannerTheme: MaterialBannerThemeData(
        // material banner theme
        ),
    dividerTheme: DividerThemeData(
        //divider, vertical divider theme
        ),
    buttonBarTheme: ButtonBarThemeData(
        // button bar theme
        ),
    fontFamily: 'ROBOTO',
    splashFactory: InkSplash.splashFactory,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Color(0xff483112),
      selectionColor: Color(0x1a483112),
      selectionHandleColor: Color(0xff483112),
    ));
