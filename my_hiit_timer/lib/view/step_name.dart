import 'package:myhiittimer/model/repositopry/hiit_repository.dart';
import 'package:myhiittimer/model/repositopry/workout_model.dart';

String stepName(WorkoutState step){
  switch(step){
    case WorkoutState.starting:
      return 'Starting';
      break;
    case WorkoutState.exercising:
      return 'Exercising';
      break;
    case WorkoutState.resting:
      return'Resting';
      break;
    case WorkoutState.breaking:
      return'Breaking';
      break;
    default:
      return 'finished';
      break;
  }
}


