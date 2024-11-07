import 'dart:io';
import 'dart:core';

import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:diabuddy/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:image_picker/image_picker.dart';

class ChooseReadOptionScreen extends StatefulWidget {
  const ChooseReadOptionScreen({super.key});

  @override
  State<ChooseReadOptionScreen> createState() => _ChooseReadOptionScreenState();
}

class _ChooseReadOptionScreenState extends State<ChooseReadOptionScreen> {
  String? _ocrText = '';
  File? selectedImage;
  String? path = '';
  String? userId;
  String? licenseNo;
  String? ptrNo;
  final ptrRegExp = RegExp(r"(PTR\.? No\.?|PTR No:|PTR No)\s*[:.]?\s*(\d+)");
  final licenseRegExp = RegExp(
      r"(Lic\.? No\.?| Lic\. No|License No\.?|License No)\s*[:.]?\s*(\d+)");

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      userId = context.read<UserAuthProvider>().user?.uid;
    });
    print(userId);
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              padding: const EdgeInsets.all(20),
              constraints: const BoxConstraints(maxHeight: 335),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldWidget(
                        callback: () {},
                        hintText: "PTR Number",
                        label: 'PTR Number',
                        type: "String"),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        callback: () {},
                        hintText: "License Number",
                        label: 'License Number',
                        type: "String"),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(
                        style: 'filled',
                        label: "Save",
                        callback: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future _pickImageFromGallery(String id) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;

    setState(() {
      selectedImage = File(returnedImage.path);
    });
    // get the file path from the File object
    String filePath = selectedImage!.path;
    // find the index of the last occurrence of "/"
    int lastIndex = filePath.lastIndexOf('/');

    // extract the substring starting from the position after the last occurrence of "/"
    String fileName = filePath.substring(lastIndex + 1);

    setState(() {
      path = '/$id/uploads/$fileName';
    });

    if (selectedImage != null) {
      _ocr(selectedImage!.path);
    }
  }

  void _ocr(image) async {
    _ocrText =
        await FlutterTesseractOcr.extractText(image, language: 'eng', args: {
      "preserve_interword_spaces": "1",
    });
    setState(() {});
    if (_ocrText != null) {
      extractLicenseAndPTR(_ocrText!);
    }
  }

  void extractLicenseAndPTR(String extractedText) {
    // extract License Number

    final licenseMatch = licenseRegExp.firstMatch(extractedText);
    licenseNo = licenseMatch?.group(2);

    // extract PTR Number
    final ptrMatch = ptrRegExp.firstMatch(extractedText);
    ptrNo = ptrMatch?.group(2);

    // print results
    print("License Number: $licenseNo");
    print("PTR Number: $ptrNo");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              const TextWidget(style: 'bodyLarge', text: "Prescription Reader"),
        ),
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2.0,
                  ),
                ),
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                width: double.infinity,
                child: Material(
                  borderRadius: BorderRadius.circular(15.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15.0),
                    splashColor: Theme.of(context).colorScheme.secondary,
                    onTap: () {
                      _pickImageFromGallery(userId!);
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Icon(
                          Icons.photo_size_select_actual_rounded,
                          color: Color.fromRGBO(100, 204, 197, 1),
                          size: 100,
                        ),
                        Text("I-upload mula sa gallery",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(100, 204, 197, 1),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2.0,
                  ),
                ),
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                width: double.infinity,
                child: Material(
                  borderRadius: BorderRadius.circular(15.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15.0),
                    splashColor: Theme.of(context).colorScheme.secondary,
                    onTap: () {
                      _showDialog(context);
                    }, // button pressed
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Icon(
                          Icons.edit_note_sharp,
                          color: Color.fromRGBO(100, 204, 197, 1),
                          size: 100,
                        ), // icon
                        Text("Ilagay ang PTR at license number",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(100, 204, 197, 1),
                            )), // text
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
