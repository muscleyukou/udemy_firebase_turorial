// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiit_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hiit _$HiitFromJson(Map<String, dynamic> json) {
  return Hiit(
    sets: json['sets'] as int,
    reps: json['reps'] as int,
    breakSeconds: json['breakSeconds'] == null
        ? null
        : Duration(microseconds: json['breakSeconds'] as int),
    exerciseSeconds: json['exerciseSeconds'] == null
        ? null
        : Duration(microseconds: json['exerciseSeconds'] as int),
    restSeconds: json['restSeconds'] == null
        ? null
        : Duration(microseconds: json['restSeconds'] as int),
    statSeconds: json['statSeconds'] == null
        ? null
        : Duration(microseconds: json['statSeconds'] as int),
  );
}

Map<String, dynamic> _$HiitToJson(Hiit instance) => <String, dynamic>{
      'sets': instance.sets,
      'reps': instance.reps,
      'statSeconds': instance.statSeconds?.inMicroseconds,
      'exerciseSeconds': instance.exerciseSeconds?.inMicroseconds,
      'restSeconds': instance.restSeconds?.inMicroseconds,
      'breakSeconds': instance.breakSeconds?.inMicroseconds,
    };
