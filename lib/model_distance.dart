class myDistance {
  final String text;

  myDistance({required this.text});

  factory myDistance.fromJson(Map<dynamic, dynamic> parsedJson) {
    return myDistance(text: parsedJson['text']);
  }
}
