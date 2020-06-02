import 'package:flutter/material.dart';
import 'package:myhiittimer/model/format/format.dart';
import 'package:myhiittimer/model/repositopry/hiit_repository.dart';
import 'package:myhiittimer/model/repositopry/workout_model.dart';
import 'package:myhiittimer/view/step_name.dart';
import 'package:screen/screen.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class WorkoutPage extends StatefulWidget {
  final Hiit hiit;
  WorkoutPage({this.hiit});

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  Workout _workout;
  @override
  initState() {
    super.initState();
    _workout=Workout(widget.hiit, _onWorkoutChanged);
    _start();
  }
  _onWorkoutChanged(){
    if(_workout.step==WorkoutState.finished){
      Screen.keepOn(false);
      setState(() {

      });
    }
    setState(() {
    });
  }
_start() {
    _workout.start();
Screen.keepOn(true);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('${stepName(_workout.step)}', style: TextStyle(fontSize: 30.0),),
              SizedBox(height: 40,),
              SleekCircularSlider(
                initialValue:widget.hiit.totalTime().inSeconds.toDouble(),
                max:widget.hiit.totalTime().inSeconds.toDouble() ,
                min: 0,
                appearance: CircularSliderAppearance(
                  spinnerDuration:2000,
                    size: 300
                ),
                innerWidget: (v) {
                  return Center(
                    child: Container(
                      child: Text(formatType(_workout.timeLeft), style: TextStyle(fontSize: 45.0),),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left:14.0),
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          TableCell(child: Text(
                            'Sets', style: TextStyle(fontSize: 24.0),),),
                          TableCell(child: Text(
                            'Reps', style: TextStyle(fontSize: 24.0),)),
                          TableCell(child: Text(
                            'Total', style: TextStyle(fontSize: 24.0),)),
                        ]
                    ),
                    TableRow(
                        children: [
                          TableCell(child: Text(
                            '${_workout.reps}/${_workout.config.reps}', style: TextStyle(fontSize: 28.0),),),
                          TableCell(child: Text(
                            '${_workout.sets}/${_workout.config.sets}', style: TextStyle(fontSize: 28.0),)),
                          TableCell(child: Text(
                            formatType(_workout.totalTime), style: TextStyle(fontSize: 28.0),)),
                        ]
                    ),
                  ],

                ),
              )
            ],
          ),
        ));
  }


}
