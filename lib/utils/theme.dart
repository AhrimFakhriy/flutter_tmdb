import 'package:flutter/material.dart';

final theme = ThemeData(
  primarySwatch: Colors.lightBlue,
  accentColor: Colors.redAccent
);

final darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.black,
  accentColor: Colors.redAccent
);