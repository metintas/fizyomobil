import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:open_file/open_file.dart'; // open_file paketini ekleyin

class bagisiklik extends StatefulWidget {
  const bagisiklik({super.key});

  @override
  _bagisiklikState createState() => _bagisiklikState();
}

class _bagisiklikState extends State<bagisiklik> {
  late YoutubePlayerController _controller;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId("https://youtu.be/X_8NAXMp0x4")!,
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
                            Expanded(
                              child: SfPdfViewer.asset(
                                  'assets/pdfFiles/bagisiklik.pdf'),
                            ),
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
