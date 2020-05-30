import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myhiittimer/model/format/format.dart';
import 'package:myhiittimer/model/repositopry/hiit_json_default.dart';
import 'package:myhiittimer/model/repositopry/hiit_repository.dart';
import 'package:myhiittimer/view/component/duration_picker.dart';
import 'package:myhiittimer/view/screen/workout_screen.dart';
import 'package:numberpicker/numberpicker.dart';
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
    setState(() {});
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
            _startTimerButton(),
            _exerciseButton(),
            _restTimeButton(),
            Row(
              children: <Widget>[
                Expanded(
                  child: _repNumberButton(),
                  flex: 1,
                ),
                Expanded(
                  child: _setNumberButton(),
                  flex: 1,
                )
              ],
            ),
            _totalTimeOutputButton(),
            _startExercise(),
          ],
        ),
      ),
    );
  }

//start button
  _startTimerButton() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              color: Colors.blueAccent,
            ),
            width: MediaQuery.of(context).size.width,
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '準備',
                  style: TextStyle(fontSize: 25.0),
                ),
                Text(
                  formatType(_hiit.startSeconds),
                  style: TextStyle(fontSize: 25.0),
                ),
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
    );
  }

//exercise button
  _exerciseButton() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              color: Colors.redAccent,
            ),
            width: MediaQuery.of(context).size.width,
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '運動時間',
                  style: TextStyle(fontSize: 25.0),
                ),
                Text(
                  formatType(_hiit.exerciseSeconds),
                  style: TextStyle(fontSize: 25.0),
                ),
              ],
            ),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DurationPicker(
                    titile: Text('set time'),
                    initialDuration: _hiit.exerciseSeconds,
                  );
                }).then((startDelay) {
              if (startDelay == null) return;
              _hiit.exerciseSeconds = startDelay;
              _saveHiit();
            });
          }),
    );
  }

  _restTimeButton() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              color: Colors.green,
            ),
            width: MediaQuery.of(context).size.width,
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '休憩時間',
                  style: TextStyle(fontSize: 25.0),
                ),
                Text(
                  formatType(_hiit.restSeconds),
                  style: TextStyle(fontSize: 25.0),
                ),
              ],
            ),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DurationPicker(
                    titile: Text('rest time'),
                    initialDuration: _hiit.restSeconds,
                  );
                }).then((startDelay) {
              if (startDelay == null) return;
              _hiit.restSeconds = startDelay;
              _saveHiit();
            });
          }),
    );
  }

  _repNumberButton() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              color: Colors.yellow,
            ),
            height: 160,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '回数',
                  style: TextStyle(fontSize: 25.0),
                ),
                Text(
                  _hiit.reps.toString(),
                  style: TextStyle(fontSize: 25.0),
                ),
              ],
            ),
          ),
          onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return NumberPickerDialog.integer(
                      minValue: 1,
                      maxValue: 10,
                      initialIntegerValue: _hiit.reps,
                    );
                  }).then((value) {
                _hiit.reps = value;
                _saveHiit();
              })),
    );
  }

  _setNumberButton() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              color: Colors.yellow,
            ),
            height: 160,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '回数',
                  style: TextStyle(fontSize: 25.0),
                ),
                Text(
                  _hiit.sets.toString(),
                  style: TextStyle(fontSize: 25.0),
                ),
              ],
            ),
          ),
          onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return NumberPickerDialog.integer(
                      minValue: 1,
                      maxValue: 10,
                      initialIntegerValue: _hiit.sets,
                    );
                  }).then((value) {
                _hiit.sets = value;
                _saveHiit();
              })),
    );
  }

  _totalTimeOutputButton() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: Colors.deepOrangeAccent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '合計時間',
              style: TextStyle(fontSize: 25.0),
            ),
            Text(
              formatType(_hiit.totalTime()),
              style: TextStyle(fontSize: 25.0),
            ),
          ],
        ),
      ),
    );
  }

  _startExercise() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: RaisedButton(child: Text('筋トレ開始',style: TextStyle(fontSize: 25.0),),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
            onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WorkoutPage(
                        hiit: _hiit,
                      )));
        }),
      ),
    );
  }
}
