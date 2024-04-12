import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:learnjava/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundProvider extends ChangeNotifier {
  final SharedPreferences? sharedPreferences;

  SoundProvider({required this.sharedPreferences}) {
    _loadSSoundStatus();
  }

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isSoundPlaying = true;

  bool get isSoundPlaying => _isSoundPlaying;

  Future<void> toggleSound() async {
    if (_isSoundPlaying) {
      await _audioPlayer.stop(); // Pause the sound
    } else {
      await initializeSound();
    }
    _isSoundPlaying = !_isSoundPlaying;
    sharedPreferences!.setBool(AppConstants.isplaying,_isSoundPlaying);
    notifyListeners();
  }


  Future<void> initializeSound() async {
    AudioCache.instance = AudioCache(prefix: '');
    await _audioPlayer.play(AssetSource('animations/sound.mp3'),volume: 2);
    _audioPlayer.onPlayerComplete.listen((_) {
      initializeSound();
    });
  }

  _loadSSoundStatus() async {
    _isSoundPlaying = sharedPreferences!.getBool(AppConstants.isplaying) ?? true;
    notifyListeners();
  }
}
