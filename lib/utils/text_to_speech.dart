import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechService {
  FlutterTts flutterTts = FlutterTts();

  @override
  void dispose() {
    flutterTts.stop(); // Stop any ongoing TTS activity before disposing
  }

  Future<void> speak(String text) async {
    print("----------------- Speaking: $text");
    flutterTts.setStartHandler(() => print("Speech started"));
    flutterTts.setCompletionHandler(() => print("Speech completed"));
    flutterTts.setErrorHandler((msg) => print("Error occurred: $msg"));

    var languages = await flutterTts.getLanguages;
    for (var language in languages) {
      print(language);
    }

    await flutterTts.setLanguage("fil-PH");
    await flutterTts.setPitch(1.25);
    await flutterTts.speak(text);
    // The method returns a bool, not an int
    bool isAvailable = await flutterTts.isLanguageAvailable("fil-PH");
    if (isAvailable) {
      // Speak first, then wait for it to complete
      await flutterTts.speak(text);
      await flutterTts.awaitSpeakCompletion(true);
      print("----------------- Speaking: $text");
    } else {
      print("Language not available");
    }
  }
}
