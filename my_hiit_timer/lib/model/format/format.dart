String formatType(Duration duration){
  String minutes=(duration.inMinutes).toString().padLeft(2,'');
  String seconds=(duration.inSeconds%60).toString().padLeft(2,'');
     return '$minutes:$seconds';
}