class Weather {
  final String description;
  final String place;

  const Weather(this.description, this.place);

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(json['weather'][0]['description'], json['name']);
  }
}
