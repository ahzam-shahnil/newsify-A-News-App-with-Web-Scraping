import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
    primaryColor: const Color(0xff12161B),
    primaryColorBrightness: Brightness.dark,
    primaryColorLight: const Color(0x1a311F06),
    primaryColorDark: const Color(0xff12161B),
    canvasColor: const Color(0xff12161B),
    scaffoldBackgroundColor: const Color(0xff12161B),
    bottomAppBarColor: const Color(0xff12161B),
    cardColor: const Color(0xff181E25),
    dividerColor: const Color(0x1f6D42CE),
    focusColor: const Color(0x1a311F06),
    hoverColor: Colors.black87,
    highlightColor: const Color(0xaf2F1E06),
    splashColor: const Color(0xff457BE0),
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
    secondaryHeaderColor: const Color(0xff12161B),
    backgroundColor: const Color(0xff457BE0),
    dialogBackgroundColor: const Color(0xff181E25),
    indicatorColor: const Color(0xff457BE0),
    hintColor: Colors.grey,
    errorColor: Colors.red,
    toggleableActiveColor: const Color(0xff6D42CE),
    textTheme: TextTheme(),
    primaryTextTheme: const TextTheme(headline4: TextStyle(color: Colors.blue)),
    buttonTheme: ButtonThemeData(),
    inputDecorationTheme: InputDecorationTheme(
// default values for InputDecorator, TextField, and TextFormField
        ),
    iconTheme: const IconThemeData(
      color: Colors.green,
    ),
    primaryIconTheme: const IconThemeData(color: Colors.green),
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
    appBarTheme: const AppBarTheme(backgroundColor: const Color(0xff12161B)),
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
        ), colorScheme: ColorScheme.fromSwatch(primarySwatch: const MaterialColor(
      0xFFF5E0C3,
      <int, Color>{
        50: const Color(0x1a5D4524),
        100: const Color(0xa15D4524),
        200: const Color(0xaa5D4524),
        300: const Color(0xaf5D4524),
        400: const Color(0x1a483112),
        500: const Color(0xa1483112),
        600: const Color(0xaa483112),
        700: const Color(0xff483112),
        800: const Color(0xaf2F1E06),
        900: const Color(0xff2F1E06)
      },
    )).copyWith(secondary: const Color(0xff457BE0)),
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
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: const Color(0xff483112),
      selectionColor: const Color(0x1a483112),
      selectionHandleColor: const Color(0xff483112),
    ));
