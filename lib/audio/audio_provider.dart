import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../res/res.dart';

class AudioProvider extends ChangeNotifier{

  final AudioPlayer musicPlayer = AudioPlayer();
  final AudioPlayer oceanPlayer = AudioPlayer();
  bool isMuted = true;
  final double oceanAudioVolume = 0.08;
  final double musicAudioVolume = 0.18;
  final double typingAudioVolume = 0.3;
  bool isOcean = false;
  int typingValue = 0;

  init(){
    setAudio();
  }

  @override
  void dispose() {
    super.dispose();
    musicPlayer.dispose();
    oceanPlayer.dispose();
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
    if(isMuted){
      musicPlayer.setVolume(0);
      oceanPlayer.setVolume(0);
    }
    else{
      playMusic();
      playOcean();
    }
  }

  playMusic(){
    musicPlayer.setVolume(musicAudioVolume);
    if(!musicPlayer.playing){
      musicPlayer.play();
    }
  }

  playOcean(){
    oceanPlayer.setVolume(oceanAudioVolume);
    if(isOcean && !oceanPlayer.playing){
      oceanPlayer.play();
    }
  }

  playTyping(int i) {
    if(!isMuted && typingValue < i){
      playType();
    }
    typingValue = i;
  }

  playType() async{
    AudioPlayer p = AudioPlayer();
    await p.setAsset('assets/audio/b.mp3');
    await p.setLoopMode(LoopMode.off);
    await p.setVolume(typingAudioVolume);
    await p.play();

    await Future.delayed(Duration(seconds: (p.duration?.inSeconds ?? 1) + 1), () async {
      p.dispose();
    });
  }
}
