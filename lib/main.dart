
import 'package:flutter/material.dart';
import 'splash_screen.dart';

var IP_Address = "192.168.29.226";
// var IP_Address = "192.168.100.6";

var userId;
var user_name;
var user_phone;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splash_screen(),
    );
  }
}

