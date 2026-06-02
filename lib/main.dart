import 'package:flutter/material.dart';


import 'pages/classify_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ML Classifier',
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
      home: ClassifyPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
