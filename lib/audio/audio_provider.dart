import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../res/res.dart';

class AudioProvider extends ChangeNotifier{

  final AudioPlayer musicPlayer = AudioPlayer();
  final AudioPlayer oceanPlayer = AudioPlayer();
  bool isMuted = true;
  final double oceanAudioVolume = 0.05;
  final double musicAudioVolume = 0.12;
  bool isOcean = false;

  init(){
    setAudio();
  }

  Future setAudio() async {
    musicPlayer.setAsset('assets/audio/ambient.mp3');
    musicPlayer.setLoopMode(LoopMode.all);
    musicPlayer.setVolume(musicAudioVolume);
    oceanPlayer.setAsset('assets/audio/gentle.mp3');
    oceanPlayer.setLoopMode(LoopMode.all);
    oceanPlayer.setVolume(0);
    Future.delayed(Duration(seconds: Dimens.totalGradientDuration), (){
      isOcean = true;
      if(!isMuted){
        oceanPlayer.play();
      }
    });
    notifyListeners();
  }

  toggleMuted(){
    isMuted = !isMuted;
  }
}
