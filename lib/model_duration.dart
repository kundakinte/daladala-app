class myDuration {
  final String text;

  myDuration({required this.text});

  factory myDuration.fromJson(Map<dynamic, dynamic> parsedJson) {
    return myDuration(text: parsedJson['text']);
  }
}
