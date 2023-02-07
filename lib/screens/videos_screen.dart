import 'package:flutter/material.dart';
import 'package:video_player_example/screens/video_player/video_player_screen.dart';
import 'package:video_player_example/utils/my_videos.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Videos")),
      body: ListView.builder(
        itemCount: MyVideos.myVideos.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VideoPlayerScreen(videoModel: MyVideos.myVideos[index]),
                )),
            title: Text(MyVideos.myVideos[index].name),
            trailing: Image.network(MyVideos.myVideos[index].image),
          );
        },
      ),
    );
  }
}
