
import 'dart:async';

import 'package:flutter/services.dart';

class SimpleAudioPlayer {
  static const MethodChannel _channel =
      const MethodChannel('simple_audio_player');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod("getPlatformVersion");
    return version;
  }

  static Future<void> play(String url) async {
    final String version = await _channel.invokeMethod("play", {
      "url": url
    });
    return version;
  }
}
