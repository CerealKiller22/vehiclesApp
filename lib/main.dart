import 'package:flutter/material.dart';
import 'package:vehicles_app/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vehicles App',
      home: const LoginScreen(), 
    );
  }
}