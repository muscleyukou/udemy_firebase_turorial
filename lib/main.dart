import 'package:flutter/material.dart';
import 'package:tasks/config.dart';
import 'package:tasks/home_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        brightness: Brightness.light,
      ),
      home: HomePage(),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor,
      ),
    );
  }
}




