// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'pages/detail_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
