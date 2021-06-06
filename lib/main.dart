import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visualize/utils.dart';

import 'home.dart';
import 'providers/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(child: MyApp()));
  if (kIsWeb) {
    piRadius = 6.1;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final theme = watch(themeProvider).theme;
        return MaterialApp(
          title: 'Sort',
          theme: theme,
          home: Home(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
