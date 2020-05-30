import 'package:myhiittimer/model/repositopry/hiit_repository.dart';

Hiit get jsonDefault =>Hiit(
  sets: 2,
  reps: 2,
  startSeconds: Duration(seconds: 10),
  exerciseSeconds: Duration(seconds: 20),
  restSeconds: Duration(seconds: 10),
  breakSeconds: Duration(seconds: 60),
);