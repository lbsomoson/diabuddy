import 'dart:io';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class TextToSpeechService {
  FlutterTts flutterTts = FlutterTts();
  String? audioPath;

  void dispose() {
    flutterTts.stop(); // stop any ongoing TTS activity before disposing
  }

  Future<void> requestStoragePermission() async {
    await Permission.storage.request();
  }

  Future<void> speak(String text, String id) async {
    print("Trying to save the audio");

    await flutterTts.setLanguage("fil-PH");
    await flutterTts.setPitch(1.25);
    await flutterTts.speak(text);
    // // the method returns a bool, not an int
    // bool isAvailable = await flutterTts.isLanguageAvailable("fil-PH");
    // if (isAvailable) {
    //   // speak first, then wait for it to complete
    //   await flutterTts.speak(text);
    //   await flutterTts.awaitSpeakCompletion(true);
    //   print("----------------- Speaking: $text");
    // } else {
    //   print("Language not available");
    // }
    // Get the directory to save the audio
    Directory dir = await getApplicationDocumentsDirectory();
    String filePath = '$id.mp3';

    // Configure flutter_tts to save the audio as a file
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);

    // Check if flutter_tts supports saving files directly
    var result = await flutterTts.synthesizeToFile(text, filePath);
    if (result == 1) {
      // Result will be 1 if the file was saved successfully
      audioPath = filePath;
      print("Audio saved at path: $audioPath");
    } else {
      print("Failed to save audio");
    }
  }
}
