class EventsModel {
  final int userId;
  final int id;
  final String title;
  final String body;
  final DateTime from;
  final DateTime to;

  EventsModel({this.userId, this.id, this.title, this.body, this.from, this.to});

  factory EventsModel.fromJson(Map<String, dynamic> json) {
    return EventsModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
      from: DateTime.parse(json['from']),
      to: DateTime.parse(json["to"])
    );
  }
}