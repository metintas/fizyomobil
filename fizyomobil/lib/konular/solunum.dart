// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


// ignore: camel_case_types
class solunum extends StatefulWidget {
  const solunum({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _solunumState createState() => _solunumState();
}

// ignore: camel_case_types
class _solunumState extends State<solunum> {
  late YoutubePlayerController _controller;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId("https://youtu.be/3m1AE-E3Lwk")!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    _controller.addListener(() {
      setState(() {
        _isFullScreen = _controller.value.isFullScreen;
      });

      if (_isFullScreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isFullScreen ? null : AppBar(),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return LayoutBuilder(
            builder: (context, constraints) {
              double playerHeight = _isFullScreen
                  ? constraints.maxHeight
                  : MediaQuery.of(context).size.width * 9 / 16;
              return Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: playerHeight,
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.blueAccent,
                      onReady: () {
                        print('Player is ready.');
                      },
                      onEnded: (data) {
                        _controller.seekTo(Duration.zero);
                      },
                    ),
                  ),
                  if (orientation == Orientation.portrait)
                    Expanded(
                      child: SafeArea(
                        child: Column(
                          children: [
                            Expanded(child: SfPdfViewer.asset('assets/pdfFiles/solunum.pdf')),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

