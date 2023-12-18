import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReplyVideoCard extends StatelessWidget {
  const ReplyVideoCard(
      {super.key,
      required this.videoUrl,
      required this.time,
      required this.onTap});
  final String videoUrl;
  final String time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 40,
                  top: 7,
                  bottom: 10,
                ),
                child: VideoPlayerWidget(
                    videoUrl:
                        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'), // Video widget for replaying video
              ),
              Positioned(
                bottom: 10,
                right: 8,
                child: Text(
                  time,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                VideoPlayer(_controller),
                IconButton(
                  icon: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    });
                  },
                ),
              ],
            ),
          )
        : const SizedBox(
            height: 300,
            child: Center(child: CircularProgressIndicator()),
          );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
