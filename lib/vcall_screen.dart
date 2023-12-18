import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:smooth_video_progress/smooth_video_progress.dart';
import 'package:tme_vcall/utils.dart';
import 'package:video_player/video_player.dart';

class VcallScreen extends StatefulWidget {
  const VcallScreen({super.key});

  @override
  State<VcallScreen> createState() => _VcallScreenState();
}

class _VcallScreenState extends State<VcallScreen> {
  late VideoPlayerController _controller;
  final Color _backgroundColor = Colors.black87;
  Duration? videoDuration;
  Duration? playingDuration;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    _controller.addListener(() {
      videoDuration = _controller.value.duration;
      playingDuration = _controller.value.position;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            // color: Colors.grey,
            child: Column(
              children: [
                SmoothVideoProgress(
                  controller: _controller,
                  builder: (context, position, duration, child) => Slider(
                    onChangeStart: (_) => _controller.pause(),
                    onChangeEnd: (_) => _controller.play(),
                    onChanged: (value) => _controller
                        .seekTo(Duration(milliseconds: value.toInt())),
                    value: position.inMilliseconds.toDouble(),
                    min: 0,
                    max: duration.inMilliseconds.toDouble(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDuration(
                            playingDuration ?? const Duration(seconds: 0)),
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        formatDuration(
                            videoDuration ?? const Duration(seconds: 0)),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // Play/Pause Button
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
