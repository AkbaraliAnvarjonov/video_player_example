import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_example/data/video_model.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({super.key, required this.videoModel});
  VideoModel videoModel;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  Duration currentDuration = Duration.zero;
  bool visibilityIcon = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoModel.url)
      ..initialize().then((_) {
        setState(() {});
      });
    _controllerObserver();
  }

  _controllerObserver() {
    _controller.addListener(() {
      currentDuration = _controller.value.position;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.videoModel.name)),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: [
                    GestureDetector(
                        onTap: () {
                          visibilityIcon = !visibilityIcon;
                          setState(() {});
                        },
                        child: VideoPlayer(_controller)),
                    Center(
                      child: Visibility(
                        visible: visibilityIcon,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  _controller.seekTo(Duration(
                                      seconds: currentDuration.inSeconds - 5));
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
                                  _controller.seekTo(Duration(
                                      seconds: currentDuration.inSeconds + 5));
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
                      child: Visibility(
                        visible: visibilityIcon,
                        child: Row(
                          children: [
                            Text(
                              currentDuration.inSeconds % 60 < 10
                                  ? "${currentDuration.inMinutes}:0${currentDuration.inSeconds % 60}"
                                  : "${currentDuration.inMinutes}:${currentDuration.inSeconds % 60}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                            SliderTheme(
                              data: const SliderThemeData(
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 4.0),
                              ),
                              child: Slider(
                                max: _controller.value.duration.inSeconds
                                    .toDouble(),
                                value: currentDuration.inSeconds.toDouble(),
                                onChanged: (value) {
                                  _controller
                                      .seekTo(Duration(seconds: value.toInt()));
                                  setState(() {});
                                },
                              ),
                            ),
                            Text(
                              _controller.value.duration.inSeconds % 60 < 10
                                  ? "${_controller.value.duration.inMinutes}:0${_controller.value.duration.inSeconds % 60}"
                                  : "${_controller.value.duration.inMinutes}:${_controller.value.duration.inSeconds % 60}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
