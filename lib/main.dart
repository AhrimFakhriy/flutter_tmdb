import 'package:flutter/material.dart';
import 'utils/services.dart';
import 'ui/app.dart';

void main() async {
  registerServices();
  runApp(App());
}