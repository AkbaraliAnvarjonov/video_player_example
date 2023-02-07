import 'package:video_player_example/data/video_model.dart';

class MyVideos {
  static List<VideoModel> myVideos = [
    VideoModel(
        "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        "https://storage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg",
        "Big Buck Bunny"),
    VideoModel(
        "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
        "https://storage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg",
        "Elephants Dream"),
    VideoModel(
        "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
        "https://storage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg",
        "For Bigger Blazes"),
  ];
}
