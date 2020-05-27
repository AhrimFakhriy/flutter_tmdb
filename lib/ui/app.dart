import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/settings.dart';
import 'screens/homepage.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      theme: theme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: Homepage(),
    );
  }
}