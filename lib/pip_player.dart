import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PipPlayer extends StatefulWidget {
  const PipPlayer({super.key});

  @override
  State<PipPlayer> createState() => _PipPlayerState();
}

class _PipPlayerState extends State<PipPlayer> {
  late Floating floating;
  late VideoPlayerController _controller;

  @override
  void initState() {
    floating = Floating();
    _controller = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4")
      ..initialize();

    _controller.setLooping(true);
    _controller.play();
    super.initState();
  }

  Widget justVideo() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: VideoPlayer(_controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PiPSwitcher(
      childWhenEnabled: justVideo(),
      childWhenDisabled: Scaffold(
        appBar: AppBar(
          title: const Text("Floating Video"),
        ),
        body: Center(
          child: justVideo(),
        ),
        floatingActionButton: PiPSwitcher(
          childWhenDisabled: FloatingActionButton(
            onPressed: () async {
              await floating.enable(aspectRatio: const Rational.landscape());
            },
            child: const Icon(Icons.picture_in_picture_rounded),
          ),
          childWhenEnabled: justVideo(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    floating.dispose();
    _controller.dispose();
    super.dispose();
  }
}
