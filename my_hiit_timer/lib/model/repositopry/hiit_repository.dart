import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
part 'hiit_repository.g.dart';


@JsonSerializable()
class Hiit {
  int sets;
  int reps;
  Duration startSeconds;
  Duration exerciseSeconds;
  Duration restSeconds;
  Duration breakSeconds;

  Hiit(
      {this.sets,
      this.reps,
      this.breakSeconds,
      this.exerciseSeconds,
      this.restSeconds,
      this.startSeconds});

  factory Hiit.fromJson(Map<String, dynamic> json) => _$HiitFromJson(json);
  Map<String, dynamic> toJson() => _$HiitToJson(this);
 Duration totalTime(){
  return  (exerciseSeconds*sets*reps)+ (restSeconds*sets*(reps-1))+(breakSeconds*sets*(reps-1));
  }
}
