class PlayListModel {
  final String url;
  final String title;

  PlayListModel({this.url, this.title});

  factory PlayListModel.fromJson(Map<String, dynamic> json){
    return PlayListModel(
      url: json['url'],
      title: json['title']
    );
  }
}