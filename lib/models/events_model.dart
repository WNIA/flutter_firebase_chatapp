class EventsModel {
  final int userId;
  final int id;
  final String email;
  final String title;
  final String body;
  final DateTime from;
  final DateTime to;

  EventsModel(
      {this.userId,
      this.id,
      this.email,
      this.title,
      this.body,
      this.from,
      this.to});

  factory EventsModel.fromJson(Map<String, dynamic> json) {
    return EventsModel(
        userId: json['userId'],
        id: json['id'],
        email: json['email'],
        title: json['title'],
        body: json['body'],
        from: DateTime.parse(json['from']),
        to: DateTime.parse(json["to"]));
  }
}
