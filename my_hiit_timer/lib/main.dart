import 'package:flutter/material.dart';
import 'package:myhiittimer/view/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  MyApp({this.prefs});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HIITタイマー',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: HomeScreen(
        prefs: prefs,
      ),
    );
  }
}
