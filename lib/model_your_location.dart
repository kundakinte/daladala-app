class YourLocation {
  final String formatted_address;

  YourLocation({required this.formatted_address});

  factory YourLocation.fromJson(Map<String, dynamic> json) {
    return YourLocation(formatted_address: json['formatted_address']);
  }
}
