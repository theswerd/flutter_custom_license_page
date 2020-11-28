import 'package:example/cupertino_example_1.dart';
import 'package:example/sliver_example_1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './flutter_custom_license_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      color: Colors.red,
      title: 'Flutter Custom License Page Demo',
      home: cupertinoExample1,
    );
  }
}
