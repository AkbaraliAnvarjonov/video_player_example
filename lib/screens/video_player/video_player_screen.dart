import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  double currentDuration = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    _controllerObserver();
  }

  _controllerObserver() {
    _controller.addListener(() {
      currentDuration = _controller.value.position.inSeconds.toDouble();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Video Screen")),
      body: Column(
        children: [
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      GestureDetector(child: VideoPlayer(_controller)),
                      Center(
                        child: Visibility(
                          visible: true,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    currentDuration -= 5;
                                    _controller.seekTo(Duration(
                                        seconds: currentDuration.toInt()));
                                  },
                                  icon: const CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.white60,
                                    child: Icon(Icons.settings_backup_restore),
                                  )),
                              const SizedBox(width: 10),
                              IconButton(
                                focusColor: Colors.grey.withOpacity(0.9),
                                onPressed: () {
                                  setState(() {
                                    _controller.value.isPlaying
                                        ? _controller.pause()
                                        : _controller.play();
                                  });
                                },
                                icon: CircleAvatar(
                                  radius: 90,
                                  backgroundColor: Colors.white60,
                                  child: Icon(
                                    _controller.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              IconButton(
                                  onPressed: () {
                                    currentDuration += 5;
                                    _controller.seekTo(Duration(
                                        seconds: currentDuration.toInt()));
                                  },
                                  icon: const CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.white60,
                                    child: Icon(Icons.refresh),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: SliderTheme(
                          data: const SliderThemeData(
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 4.0),
                          ),
                          child: Slider(
                            max:
                                _controller.value.duration.inSeconds.toDouble(),
                            value: currentDuration,
                            onChanged: (value) {
                              currentDuration = value;
                              _controller
                                  .seekTo(Duration(seconds: value.toInt()));
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
