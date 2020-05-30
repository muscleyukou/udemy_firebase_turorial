import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:myhiittimer/model/repositopry/hiit_repository.dart';
var player = AudioCache();
enum WorkoutState{
  initial,starting,exercising,resting,breaking,finished
}

class Workout{
  Hiit _config;

  Function _onSateChange;

  int _reps=0;
  int _sets=0;
  Timer _timer;
  Duration _timeLeft;
  Duration _totalTime=Duration(seconds: 0);
  WorkoutState _step=WorkoutState.initial;

  Workout(this._config,this._onSateChange);

  void start(){
    if(_step==WorkoutState.initial){
      _step=WorkoutState.starting;
    }if(_config.startSeconds.inSeconds==0){
      _next();
    }else{
      _timeLeft=_config.startSeconds;
    }
    _timer=Timer.periodic(Duration(seconds: 1), _tick);
    _onSateChange();
  }


  void _tick(Timer timer) {
    if(_step!=WorkoutState.starting){
      _totalTime+=Duration(seconds: 1);
    }
   if(_timeLeft.inSeconds==1){
     _next();
   }else{
     _timeLeft-=Duration(seconds: 1);
     if(_timeLeft.inSeconds<=3&&_timeLeft.inSeconds<0){
       //todo play music
     }
   }
_onSateChange();
  }

  void _next() {
    if (_step == WorkoutState.exercising) {
      if (reps == _config.reps) {
        if (sets == _config.sets) {
          _finish();
        } else {
          _startBreak();
        }
      } else {
        _startRest();
      }
    } else if (_step == WorkoutState.resting) {
      _startRep();
    } else if (_step == WorkoutState.starting ||
        _step == WorkoutState.breaking) {
      _startSet();
    }
  }
//start method
  void _startSet() {
   _timeLeft=_config.exerciseSeconds;
   _step=WorkoutState.exercising;
   _sets++;
   _reps=1;
   //todo playsound
  }
//break
  void _startBreak() {
    _step=WorkoutState.breaking;
    _timeLeft=_config.breakSeconds;
    if(_config.breakSeconds.inSeconds==0){
      _next();
      return;
    }
    //todo nextstep
    //todo playsound
  }
//finish
  void _finish() {
    _timer.cancel();
    _step=WorkoutState.finished;
    _timeLeft=Duration(seconds: 0);//seconds 0にすることで進まなくなる
    //todo playsound
  }
//startrep
  void _startRep() {
    _timeLeft=_config.exerciseSeconds;
    _step=WorkoutState.exercising;
    _reps++;
    //todo playsound
  }
  void _startRest() {
    _step=WorkoutState.resting;
    if(_config.restSeconds.inSeconds==0){
      _next();
      return;
    }
    _timeLeft=_config.restSeconds;
  }
  get config=>_config;
  get sets =>_sets;
  get reps=>_reps;
  get step=>_step;
  get timeLeft=>_timeLeft;
  get totalTime=>_totalTime;


}