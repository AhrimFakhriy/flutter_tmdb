import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CenteredLoader extends StatelessWidget {
  const CenteredLoader();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid 
        ? const CircularProgressIndicator()
        : const CupertinoActivityIndicator()
    );
  }
}