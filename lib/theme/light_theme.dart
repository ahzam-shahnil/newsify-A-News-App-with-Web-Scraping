import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
    primaryColor: const Color(0xfffbfaff),
    primaryColorBrightness: Brightness.light,
    primaryColorLight: const Color(0xffb0b5b3),
    primaryColorDark: Colors.blue,
    canvasColor: const Color(0xfff0efeb),
    scaffoldBackgroundColor: const Color(0xffe9ecef),
    appBarTheme: AppBarTheme(backgroundColor: const Color(0xffe9ecef)),
    cardColor: Colors.grey.shade200,
    dividerColor: const Color(0xffced4da),
    focusColor: const Color(0x1aF5E0C3),
    hoverColor: const Color(0xffDEC29B),
    highlightColor: const Color(0xffd8e2dc),
    splashColor: const Color(0xff457BE0),
//  splashFactory: # override create method from  InteractiveInkFeatureFactory
    selectedRowColor: Colors.grey,
    unselectedWidgetColor: Colors.grey.shade400,
    disabledColor: Colors.grey.shade200,
    buttonTheme: const ButtonThemeData(buttonColor: Colors.red),
    toggleButtonsTheme: ToggleButtonsThemeData(
        //toggle button theme
        ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      backgroundColor: Colors.green,
    )),
    secondaryHeaderColor: Colors.grey,
    backgroundColor: const Color(0xff457BE0),
    dialogBackgroundColor: Colors.white,
    indicatorColor: const Color(0xff457BE0),
    hintColor: Colors.black,
    errorColor: Colors.red,
    toggleableActiveColor: const Color(0xff6D42CE),
    textTheme: TextTheme(
      
        ),
    primaryTextTheme: const TextTheme(headline4: TextStyle(color: Colors.blue)),
    inputDecorationTheme: InputDecorationTheme(
        // default values for InputDecorator, TextField, and TextFormField
        ),
    iconTheme: const IconThemeData(color: Colors.green),
    primaryIconTheme: const IconThemeData(color: Colors.green),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: const Color(0xff936F3E),
      selectionColor: const Color(0xffB5BFD3),
      selectionHandleColor: const Color(0xff936F3E),
    ),
    tabBarTheme: TabBarTheme(
        // tab bat theme
        ),
    tooltipTheme: TooltipThemeData(
        // tool tip theme
        ),
    cardTheme: CardTheme(
        // card theme
        ),
    platform: TargetPlatform.android,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    applyElevationOverlayColor: true,
    pageTransitionsTheme: PageTransitionsTheme(
        //page transition theme
        ),
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
    navigationRailTheme: NavigationRailThemeData(),
    typography: Typography.material2018(),
    bottomSheetTheme: BottomSheetThemeData(
        //bottom sheet theme
        ),
    popupMenuTheme: PopupMenuThemeData(),
    bannerTheme: MaterialBannerThemeData(), colorScheme: ColorScheme.fromSwatch(primarySwatch: const MaterialColor(
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
    )).copyWith(secondary: const Color(0xff457BE0)),
    dividerTheme: DividerThemeData(
        //divider, vertical divider theme
        ),
    buttonBarTheme: ButtonBarThemeData(
        // button bar theme
        ),
    fontFamily: 'ROBOTO',
    splashFactory: InkSplash.splashFactory);
