import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class PlayScreen extends StatefulWidget {
  final String url;

  const PlayScreen({Key? key, required this.url}) : super(key: key);

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });

    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: false,
      looping: false,
      aspectRatio: 16 / 9,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff010125),
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
          handleKeyEvent(event);
        },
        child: Center(
          child: _controller.value.isInitialized
              ? Chewie(controller: _chewieController)
              : CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  void handleKeyEvent(RawKeyEvent event) {
    // Assuming 'Select', 'Play/Pause', 'Rewind', 'Fast Forward', 'Volume Up', 'Volume Down' key events
    if (event is RawKeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.select) {
        // Handle center button press to play/pause
        _controller.value.isPlaying
            ? _controller.pause()
            : _controller.play();
      } else if (event.logicalKey == LogicalKeyboardKey.mediaPlayPause) {
        // Handle play/pause action (if your device uses mediaPlayPause)
        _controller.value.isPlaying
            ? _controller.pause()
            : _controller.play();
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        // Handle rewind action
        // Adjust the rewind duration as needed
        _controller.seekTo(_controller.value.position - Duration(seconds: 10));
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        // Handle fast forward action
        // Adjust the fast forward duration as needed
        _controller.seekTo(_controller.value.position + Duration(seconds: 10));
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        // Handle Up button press for volume up
        _controller.setVolume((_controller.value.volume + 0.1).clamp(0.0, 1.0));
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        // Handle Down button press for volume down
        _controller.setVolume((_controller.value.volume - 0.1).clamp(0.0, 1.0));
      }
      else if (event.logicalKey == LogicalKeyboardKey.home) {
        // Handle Home button press to navigate back
        Navigator.of(context).pop();
      }
    }
  }



  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }
}
