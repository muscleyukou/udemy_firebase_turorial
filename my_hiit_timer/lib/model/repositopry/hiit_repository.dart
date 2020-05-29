import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
part 'hiit_repository.g.dart';


@JsonSerializable()
class Hiit {
  int sets;
  int reps;
  Duration statSeconds;
  Duration exerciseSeconds;
  Duration restSeconds;
  Duration breakSeconds;


  Hiit(
      {this.sets,
      this.reps,
      this.breakSeconds,
      this.exerciseSeconds,
      this.restSeconds,
      this.statSeconds});

  factory Hiit.fromJson(Map<String, dynamic> json) => _$HiitFromJson(json);

  Map<String, dynamic> toJson() => _$HiitToJson(this);
}
