import 'package:flutter/material.dart';
import 'package:myhiittimer/view/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  var prefs=await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;
  MyApp({this.prefs});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HIITタイマー',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: HomeScreen(
        prefs:widget.prefs,
      ),
    );
  }
}
