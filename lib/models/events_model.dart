class Events {
  final int userId;
  final int id;
  final String title;
  final String body;
  final DateTime from;
  final DateTime to;

  Events({this.userId, this.id, this.title, this.body, this.from, this.to});

  factory Events.fromJson(Map<String, dynamic> json) {
    return Events(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
      from: DateTime.parse(json['from']),
      to: DateTime.parse(json["to"])
    );
  }
}