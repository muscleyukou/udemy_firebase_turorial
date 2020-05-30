import 'package:flutter/material.dart';
import 'package:myhiittimer/model/repositopry/hiit_repository.dart';
import 'package:numberpicker/numberpicker.dart';

class DurationPicker extends StatefulWidget {
  final Widget titile;
  final Duration initialDuration;

  DurationPicker({ this.titile, this.initialDuration});

  @override
  _DurationPickerState createState() => _DurationPickerState(initialDuration);
}

class _DurationPickerState extends State<DurationPicker> {
  int minutes;
  int seconds;

  _DurationPickerState(Duration initialDuration) {
    minutes = initialDuration.inMinutes;
    seconds = initialDuration.inSeconds % Duration.secondsPerMinute;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.titile,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          NumberPicker.integer(
              initialValue: minutes,
              minValue: 0,
              maxValue: 10,
              zeroPad: true,
              onChanged: (number) {
                setState(() {
                  minutes = number;
                });
              }),
          Text(':'),
          NumberPicker.integer(
              initialValue: seconds,
              minValue: 0,
              maxValue: 59,
              zeroPad: true,
              onChanged: (value) {
                setState(() {
                  seconds = value;
                });
              }),
        ],
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop(
                Duration(minutes: minutes, seconds: seconds),
              );
            },
            child: Text('はい')),
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('いいえ')),
      ],
    );
  }
}
