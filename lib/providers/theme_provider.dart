import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    var prefs = state.prefs;

    prefs ??= await SharedPreferences.getInstance();

    state = state.copyWith(
      darkTheme: !state.darkTheme,
      prefs: prefs,
      primaryColor: state.darkTheme ? Colors.white : const Color(0xFF26283D),
      accentColor: state.darkTheme ? Colors.black : Colors.white,
    );
  }
}

@immutable
class ThemeProvider {
  final bool darkTheme;
  final SharedPreferences? prefs;
  final Color primaryColor;
  final Color accentColor;

  ThemeProvider({
    this.darkTheme = false,
    this.prefs,
    this.primaryColor = Colors.white,
    this.accentColor = const Color(0xFF26283D),
  });

  ThemeData get theme {
    return themeData();
  }

  ThemeProvider copyWith({
    bool? darkTheme,
    SharedPreferences? prefs,
    Color? primaryColor,
    Color? accentColor,
  }) {
    return ThemeProvider(
      darkTheme: darkTheme ?? this.darkTheme,
      prefs: prefs ?? this.prefs,
      primaryColor: primaryColor ?? this.primaryColor,
      accentColor: accentColor ?? this.accentColor,
    );
  }

  ThemeData themeData() {
    return ThemeData(
      brightness: darkTheme ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor:
          darkTheme ? const Color(0xFF111422) : const Color(0xFFEFF2FA),
      accentColor: darkTheme ? Colors.white : const Color(0xFF26283D),
      indicatorColor: accentColor,
      primaryColor: primaryColor,
      textTheme: TextTheme(
        headline6: GoogleFonts.openSans().copyWith(color: accentColor),
        subtitle1: GoogleFonts.openSans().copyWith(color: accentColor),
        caption: GoogleFonts.openSans().copyWith(color: accentColor),
      ),
      appBarTheme: AppBarTheme(
        color: primaryColor,
        iconTheme: IconThemeData(
          color: accentColor,
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: accentColor,
        unselectedLabelColor: accentColor.withOpacity(0.3),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor:
            darkTheme ? const Color(0xFFCBCBCB) : const Color(0xFF111422),
      ),
    );
  }

  bool get darkThemeValue {
    return darkTheme;
  }
}
