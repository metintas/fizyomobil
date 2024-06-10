import 'package:flutter/material.dart';
import 'package:babylonjs_viewer/babylonjs_viewer.dart';

class Models extends StatefulWidget {
  const Models({super.key});

  @override
  _ModelsState createState() => _ModelsState();
}

class _ModelsState extends State<Models> {
  int? selectedImageIndex;
  double _scale = 1.0;
  double _previousScale = 1.0;
  double _rotation = 0.0;
  double _previousRotation = 0.0;

  List<String> images = [
    "assets/model_images/bobrek.jpg",
    "assets/model_images/dolasim.png",
    "assets/model_images/duyu1.jpg",
    "assets/model_images/duyu2.jpg",
    "assets/model_images/iskelet.jpg",
    "assets/model_images/kas.png",
    "assets/model_images/sinir.jpg",
    "assets/model_images/solunum.jpg",
  ];

  List<String> models = [
    "assets/TDmodels/bobrek.glb",
    "assets/TDmodels/dolasim.glb",
    "assets/TDmodels/duyu.glb",
    "assets/TDmodels/duyu2.glb",
    "assets/TDmodels/iskelet.glb",
    "assets/TDmodels/kas.glb",
    "assets/TDmodels/sinir.glb",
    "assets/TDmodels/solunum.glb",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "3B Modellerle Öğrenme",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < images.length; i++)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedImageIndex == i) {
                              selectedImageIndex = null;
                            } else {
                              selectedImageIndex = i;
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 200,
                            height: MediaQuery.of(context).size.height * 0.25,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 7,
                                )
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              child: Image.asset(
                                images[i],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              selectedImageIndex != null
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onScaleStart: (details) {
                            _previousScale = _scale;
                            _previousRotation = _rotation;
                          },
                          onScaleUpdate: (details) {
                            setState(() {
                              _scale = _previousScale * details.scale;
                              _rotation = _previousRotation + details.rotation;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..scale(_scale)
                                  ..rotateZ(_rotation),
                                child: BabylonJSViewer(
                                  src: models[selectedImageIndex!],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const Models());
}
