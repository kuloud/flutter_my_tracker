import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:x_common/utils/logger.dart';

enum TtsState { playing, stopped, paused, continued }

class TtsService {
  static final TtsService _instance = TtsService._internal();
  factory TtsService() => _instance;
  TtsService._internal();

  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 0.8;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  TtsState ttsState = TtsState.stopped;

  bool get isPlaying => ttsState == TtsState.playing;
  bool get isStopped => ttsState == TtsState.stopped;
  bool get isPaused => ttsState == TtsState.paused;
  bool get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;

  Future<void> initTts() async {
    flutterTts = FlutterTts();
    await _setAwaitOptions();

    if (isAndroid) {
      await _getDefaultEngine();
      await _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      logger.d("Playing");
      ttsState = TtsState.playing;
    });

    flutterTts.setCompletionHandler(() {
      logger.d("Complete");
      ttsState = TtsState.stopped;
    });

    flutterTts.setCancelHandler(() {
      logger.d("Cancel");
      ttsState = TtsState.stopped;
    });

    flutterTts.setPauseHandler(() {
      logger.d("Paused");
      ttsState = TtsState.paused;
    });

    flutterTts.setContinueHandler(() {
      logger.d("Continued");
      ttsState = TtsState.continued;
    });

    flutterTts.setErrorHandler((msg) {
      logger.w("error: $msg");
      ttsState = TtsState.stopped;
    });
  }

  Future<List<String>> getLanguages() async {
    return await flutterTts.getLanguages;
  }

  Future<List<String>> getEngines() async {
    return await flutterTts.getEngines;
  }

  Future<void> _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      logger.d(engine);
    }
  }

  Future<void> _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      logger.d(voice);
    }
  }

  Future<void> speak(String text) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (text.isNotEmpty) {
      await flutterTts.speak(text);
    }
  }

  Future<void> _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> stop() async {
    var result = await flutterTts.stop();
    if (result == 1) ttsState = TtsState.stopped;
  }

  Future<void> pause() async {
    var result = await flutterTts.pause();
    if (result == 1) ttsState = TtsState.paused;
  }

  Future<void> setEngine(String engine) async {
    await flutterTts.setEngine(engine);
    this.engine = engine;
  }

  Future<void> setLanguage(String language) async {
    await flutterTts.setLanguage(language);
    this.language = language;
    if (isAndroid) {
      isCurrentLanguageInstalled =
          await flutterTts.isLanguageInstalled(language);
    }
  }

  Future<int?> getMaxSpeechInputLength() async {
    return await flutterTts.getMaxSpeechInputLength;
  }

  void setVolume(double volume) {
    this.volume = volume;
  }

  void setPitch(double pitch) {
    this.pitch = pitch;
  }

  void setRate(double rate) {
    this.rate = rate;
  }
}
