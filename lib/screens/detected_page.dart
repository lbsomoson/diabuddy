import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:flutter/material.dart';

class DetectedPage extends StatefulWidget {
  final List<String>? detectedObjectsList;
  final Widget? imgBoundingBox;
  const DetectedPage(
      {super.key, this.detectedObjectsList, this.imgBoundingBox});

  @override
  State<DetectedPage> createState() => _DetectedPageState();
}

class _DetectedPageState extends State<DetectedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const AppBarTitle(title: "Detected Image")),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
            child: widget.detectedObjectsList != null &&
                    widget.imgBoundingBox != null
                ? Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[100],
                              border: Border.all(
                                  width: 2, color: Colors.grey[200]!)),
                          child: Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: widget.imgBoundingBox,
                              ),
                              widget.detectedObjectsList != null
                                  ? Text(widget.detectedObjectsList![0])
                                  : const SizedBox()
                            ],
                          ))
                    ],
                  )
                : const Column(
                    children: [Text("Image not recognized")],
                  ),
          )),
        ));
  }
}
