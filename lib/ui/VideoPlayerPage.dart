import 'package:flutter/material.dart';
import 'package:testing_app/widgets/widget.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String name;
  final String url;

  VideoPlayerScreen(this.name, this.url);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.url);
    print(widget.url);
    _initializeVideoPlayerFuture = _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, widget.name),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            if(_controller.value.isPlaying){
              _controller.pause();
            }else{
              _controller.play();
            }
          });
        },
        child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow_outlined),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: VideoPlayer(_controller),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
