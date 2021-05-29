import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils.dart';

final themeProvider = StateNotifierProvider<ThemeProviderState, ThemeProvider>(
  (ref) {
    return ThemeProviderState();
  },
);

class ThemeProviderState extends StateNotifier<ThemeProvider> {
  ThemeProviderState()
      : super(
          ThemeProvider(),
        );

  void toggleTheme() async {
    print('changed toggle');
    var prefs = state.prefs;

    prefs ??= await SharedPreferences.getInstance();

    state = state.copyWith(
      darkTheme: !state.darkTheme,
      prefs: prefs,
      primaryColor: state.darkTheme ? Colors.white : Colors.black,
    );
  }
}

@immutable
class ThemeProvider {
  final bool darkTheme;
  final SharedPreferences? prefs;
  final Color primaryColor;
  final Color counterColor;

  ThemeProvider({
    this.darkTheme = false,
    this.prefs,
    this.primaryColor = Colors.white,
    this.counterColor = sortedColor,
  });

  ThemeData get theme {
    return themeData();
  }

  ThemeProvider copyWith({
    bool? darkTheme,
    SharedPreferences? prefs,
    Color? primaryColor,
    Color? counterColor,
  }) {
    return ThemeProvider(
      darkTheme: darkTheme ?? this.darkTheme,
      prefs: prefs ?? this.prefs,
      primaryColor: primaryColor ?? this.primaryColor,
      counterColor: counterColor ?? this.counterColor,
    );
  }

  ThemeData themeData() {
    return ThemeData(
      brightness: darkTheme ? Brightness.dark : Brightness.light,
      accentColor: counterColor,
      indicatorColor: counterColor,
      primaryColor: primaryColor,
      textTheme: TextTheme(
        headline6: GoogleFonts.openSans().copyWith(color: counterColor),
        subtitle1: GoogleFonts.openSans().copyWith(color: counterColor),
        caption: GoogleFonts.openSans().copyWith(color: counterColor),
      ),
      appBarTheme: AppBarTheme(
        color: primaryColor,
        iconTheme: IconThemeData(
          color: counterColor,
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: counterColor,
        unselectedLabelColor: counterColor.withOpacity(0.3),
      ),
    );
  }

  bool get darkThemeValue {
    return darkTheme;
  }
}
