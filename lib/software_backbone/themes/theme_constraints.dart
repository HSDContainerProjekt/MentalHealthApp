import 'package:flutter/material.dart';

//#region Color schemes for background and highlights
/// example what color is used for what https://api.flutter.dev/flutter/material/ColorScheme-class.html



/// Base color
/// The base color schemes should contain the default colors used on every page like the background color.
ColorScheme lightColorSchemeBase = const ColorScheme.light(
  brightness: Brightness.light,
  surface: Color(0xFFE6E6E6),
);
ColorScheme darkColorSchemeBase = const ColorScheme.dark(
  brightness: Brightness.dark,
  surface: Color(0xFF1E1E1E),
);

/// Page specific colors
/// MainPage
ColorScheme lightMainPageColorScheme = lightColorSchemeBase.copyWith(
  primary: const Color(0xFFFF0000),
);
ColorScheme darkMainPageColorScheme = darkColorSchemeBase.copyWith(
  primary: const Color(0xFFC80000),
);

/// Routines
ColorScheme lightRoutinePageColorScheme = lightColorSchemeBase.copyWith(
  primary: const Color(0xFFFF8000),
);
ColorScheme darkRoutineColorScheme = darkColorSchemeBase.copyWith(
  primary: const Color(0xFFC86400),
  onPrimary: const Color(0xFFC86400),
);

/// Friends
ColorScheme lightFriendsPageColorScheme = lightColorSchemeBase.copyWith(
  primary: const Color(0xFF00FF00),
);
ColorScheme darkFriendsColorScheme = darkColorSchemeBase.copyWith(
  primary: const Color(0xFF00C800),
);

/// External resources
ColorScheme lightResourcesPageColorScheme = lightColorSchemeBase.copyWith(
  primary: const Color(0xFF0080FF),
);
ColorScheme darkResourcesColorScheme = darkColorSchemeBase.copyWith(
  primary: const Color(0xFF0064C8),
);
//#endregion

//#region Text themes how the text should look like. Color, font etc.
/// example for texts https://api.flutter.dev/flutter/material/TextTheme-class.html

/// Base TextTheme
/// The base TextTheme contains the default text description like font, size or default colors.
TextTheme textThemeBase = const TextTheme(
  /// Titles are normally centered
  /// Page headline like Mainpage, Routine...
  titleLarge: TextStyle(
    fontSize: 64,
    decoration: TextDecoration.underline,
    decorationThickness: 5,
    fontFamily: 'Italianno',
  ),

  /// Subpage title used for declaration like edit or the detail name
  titleMedium: TextStyle(
    fontSize: 32,
    decoration: TextDecoration.underline,
    decorationThickness: 5,
    fontFamily: 'Italianno',
  ),

  /// The title in elements
  titleSmall: TextStyle(
    fontSize: 23,
    decoration: TextDecoration.underline,
    decorationThickness: 3,
  ),

  ///Headlines are normally left aligned and used to describe sections
  /// Unused and not defined yet
  headlineLarge: TextStyle(
    color: Color(0xFFFF00FF),
  ),

  headlineMedium: TextStyle(
    fontSize: 32,
    fontFamily: 'Italianno',
  ),

  /// Unused and not defined yet
  headlineSmall: TextStyle(
    color: Color(0xFFFF00FF),
  ),

  /// Unused and not defined yet
  labelLarge: TextStyle(
    color: Color(0xFFFF00FF),
  ),

  /// Is used to label buttons with text as main information
  labelMedium: TextStyle(
    fontSize: 25,
  ),

  /// Is used to label hints
  labelSmall: TextStyle(
    fontSize: 20,
  ),

  /// Text, which is the main content of the page
  bodyLarge: TextStyle(
    fontSize: 20,
  ),

  /// Text that is in an element on the page
  bodyMedium: TextStyle(
    fontSize: 14,
  ),

  /// Unused and not defined yet
  bodySmall: TextStyle(
    color: Color(0xFFFF00FF),
  ),

  /// Unused and not defined yet
  displayLarge: TextStyle(
    color: Color(0xFFFF00FF),
  ),

  displayMedium: TextStyle(
    color: Color(0xFFFF00FF),
  ),

  /// Unused and not defined yet
  displaySmall: TextStyle(
    color: Color(0xFFFF00FF),
  ),
);

/// The Light and Dark Versions contains the color information's
TextTheme lightTextTheme = textThemeBase.copyWith(
  displayLarge:
      textThemeBase.headlineMedium?.copyWith(color: const Color(0xFF1E1E1E)),
);
TextTheme darkTextTheme = textThemeBase.copyWith(
  displayLarge:
      textThemeBase.headlineMedium?.copyWith(color: const Color(0xFFE6E6E6)),
);

/// Page specific textThemes
/// MainPage
TextTheme lightMainPageTextTheme = lightTextTheme.copyWith();
TextTheme darkMainPageTextTheme = darkTextTheme.copyWith();

/// Routines
TextTheme lightRoutinesPageTextTheme = lightTextTheme.copyWith();
TextTheme darkRoutinesPageTextTheme = darkTextTheme.copyWith();

/// Friends
TextTheme lightFriendsPageTextTheme = lightTextTheme.copyWith();
TextTheme darkFriendsPageTextTheme = darkTextTheme.copyWith();

/// External resources
TextTheme lightResourcesPageTextTheme = lightTextTheme.copyWith();
TextTheme darkResourcesPageTextTheme = darkTextTheme.copyWith();
//#endregion

//#region ThemeData combination from text and color schemes

/// Page specific themeData
/// MainPage
ThemeData lightMainPageThemeData = ThemeData(
  brightness: Brightness.light,
  colorScheme: lightMainPageColorScheme,
  textTheme: lightMainPageTextTheme,
);
ThemeData darkMainPageThemeData = ThemeData(
  brightness: Brightness.dark,
  colorScheme: darkMainPageColorScheme,
  textTheme: darkMainPageTextTheme,
);

/// Routines
ThemeData lightRoutinesPageThemeData = ThemeData(
  brightness: Brightness.light,
  colorScheme: lightRoutinePageColorScheme,
  textTheme: lightRoutinesPageTextTheme,
);
ThemeData darkRoutinesPageThemeData = ThemeData(
  brightness: Brightness.dark,
  colorScheme: darkRoutineColorScheme,
  textTheme: darkRoutinesPageTextTheme,
);

/// Friends
ThemeData lightFriendsPageThemeData = ThemeData(
  brightness: Brightness.light,
  colorScheme: lightFriendsPageColorScheme,
  textTheme: lightFriendsPageTextTheme,
);
ThemeData darkFriendsPageThemeData = ThemeData(
  brightness: Brightness.dark,
  colorScheme: darkFriendsColorScheme,
  textTheme: darkFriendsPageTextTheme,
);

/// External resources
ThemeData lightResourcesPageThemeData = ThemeData(
  brightness: Brightness.light,
  colorScheme: lightResourcesPageColorScheme,
  textTheme: lightResourcesPageTextTheme,
);
ThemeData darkResourcesPageThemeData = ThemeData(
  brightness: Brightness.dark,
  colorScheme: darkResourcesColorScheme,
  textTheme: darkResourcesPageTextTheme,
);
//#endregion
