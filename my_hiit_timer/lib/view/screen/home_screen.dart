import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myhiittimer/model/format/format.dart';
import 'package:myhiittimer/model/repositopry/hiit_json_default.dart';
import 'package:myhiittimer/model/repositopry/hiit_repository.dart';
import 'package:myhiittimer/view/component/duration_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final SharedPreferences prefs;

  HomeScreen({@required this.prefs});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Hiit _hiit;

  _saveHiit() {
    setState(() {
    });
    _hiitSave();
  }

  _hiitSave() {
    widget.prefs.setString('hiit', jsonEncode(_hiit.toJson()));
  }

  @override
  void initState() {
    var json = widget.prefs.getString('hiit');
    _hiit = json != null ? Hiit.fromJson(jsonDecode(json)) : jsonDefault;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: Column(
                    children: <Widget>[
                      Text('準備'),
                      Text(formatType(_hiit.startSeconds)),
                    ],
                  ),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DurationPicker(
                          titile: Text('set time'),
                          initialDuration: _hiit.startSeconds,
                        );
                      }).then((startDelay) {
                    if (startDelay == null) return;
                    _hiit.startSeconds = startDelay;
                    _saveHiit();
                  });
                }),
          ],
        ),
      ),
    );
  }
}
