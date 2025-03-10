import 'package:flutter/material.dart';

//#region Color schemes for background and highlights
/// example what color is used for what https://api.flutter.dev/flutter/material/ColorScheme-class.html

ColorScheme baseColorScheme = const ColorScheme.light(
  surface: Color(0xFFFFFFFF),
  error: Color(0xFFC80000),
);

/// Page specific colors

/// MainPage
ColorScheme tableOfContentsPageColorScheme = baseColorScheme.copyWith(
  primary: const Color(0xFFb2dfd2),
);

/// MainPage
ColorScheme mainPageColorScheme = baseColorScheme.copyWith(
  primary: const Color(0xFFf178ab),
);

/// Routines
ColorScheme routinePageColorScheme = baseColorScheme.copyWith(
  primary: const Color(0xFFd6e16d),
);

/// Friends
ColorScheme friendsPageColorScheme = baseColorScheme.copyWith(
  primary: const Color(0xFFa0c4e8),
);

/// External resources
ColorScheme resourcesPageColorScheme = baseColorScheme.copyWith(
  primary: const Color(0xFFcf98c4),
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
    height: 1,
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

//#region ThemeData combination from text and color schemes

ThemeData basePageThemeData = ThemeData(
  colorScheme: baseColorScheme,
  textTheme: textThemeBase,
);

/// Page specific themeData
/// MainPage
ThemeData mainPageThemeData = basePageThemeData.copyWith(
  colorScheme: mainPageColorScheme,
);

/// Routines
ThemeData routinesPageThemeData = basePageThemeData.copyWith(
    colorScheme: routinePageColorScheme,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: routinePageColorScheme.primary,
    ),
    textSelectionTheme:
        TextSelectionThemeData(selectionColor: routinePageColorScheme.primary));

/// Friends
ThemeData friendsPageThemeData = basePageThemeData.copyWith(
  colorScheme: friendsPageColorScheme,
);

/// External resources
ThemeData resourcesPageThemeData = basePageThemeData.copyWith(
  colorScheme: resourcesPageColorScheme,
);
//#endregion
