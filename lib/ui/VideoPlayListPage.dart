import 'package:flutter/material.dart';
import 'package:testing_app/models/playlist_model.dart';
import 'package:testing_app/services/playlist_api.dart';

import 'package:http/http.dart' as http;
import 'package:testing_app/ui/VideoPlayerPage.dart';
import 'package:testing_app/widgets/widget.dart';

class VideoPlayList extends StatefulWidget {
  @override
  _VideoPlayListState createState() => _VideoPlayListState();
}

class _VideoPlayListState extends State<VideoPlayList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, 'PlayList'),
      body: futureBuilder(),
    );
  }

  FutureBuilder<List<PlayListModel>> futureBuilder() {
    return FutureBuilder<List<PlayListModel>>(
      future: fetchPlayList(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? playList(snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget playList(List<PlayListModel> videos) {
    return Container(
        // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return videoTile(videos, index);
            }));
  }

  Widget videoTile(videos, index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(
                      videos[index].title, videos[index].url)));
        },
        child: Card(
          elevation: 3,
          child: ListTile(
            title: Text(videos[index].title, style: TextStyle(fontSize: 18)),
            subtitle: Text(videos[index].url),
            trailing: Icon(Icons.play_arrow_outlined),
          ),
        ),
      ),
    );
  }
}
