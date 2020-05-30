import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myhiittimer/model/format/format.dart';
import 'package:myhiittimer/model/repositopry/hiit_json_default.dart';
import 'package:myhiittimer/model/repositopry/hiit_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final SharedPreferences prefs;
  HomeScreen({this.prefs});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Hiit _hiit;

  @override
  void initState() {
    var json= widget.prefs.getString('hiit');
    _hiit=json !=null ?Hiit.fromJson(jsonDecode(json)):jsonDefault;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          InkWell(
            child: Column(
              children: <Widget>[
                Text('準備'),
                Text(formatType(_hiit.statSeconds)),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
