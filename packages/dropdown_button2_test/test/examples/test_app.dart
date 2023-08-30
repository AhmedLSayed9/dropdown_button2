import 'package:flutter/material.dart';

class TestApp extends StatelessWidget {
  const TestApp({required this.widget, super.key});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: widget,
    );
  }
}
