import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ps/util/animated_gradient.dart';
import 'package:ps/background/background.dart';
import 'package:ps/res/res.dart';


class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool backgroundVisible = false;
  final AudioPlayer musicPlayer = AudioPlayer();
  final AudioPlayer oceanPlayer = AudioPlayer();
  bool isMuted = true;
  final double oceanAudioVolume = 0.05;
  final double musicAudioVolume = 0.12;
  bool isOcean = false;

  @override
  void initState() {
    super.initState();
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
      setState(() {
        isOcean = true;
        if(!isMuted){
          oceanPlayer.play();
        }
      });
    });
  }


  @override
  void dispose() {
    super.dispose();
    musicPlayer.dispose();
    oceanPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), (){setState(() {
      backgroundVisible = true;
    });});
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          AnimatedGradient(),
          AnimatedOpacity(
            duration: Duration(seconds: 5),
            opacity: backgroundVisible ? 1.0 : 0.0,
            child: BackgroundStack(isGame: true)),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  isMuted = !isMuted;
                });
                if(!isMuted && !musicPlayer.playing){
                  musicPlayer.play();
                }
                else if(!isMuted){
                  musicPlayer.setVolume(musicAudioVolume);
                }
                else{
                  musicPlayer.setVolume(0);
                }
                if(!isMuted){
                  oceanPlayer.setVolume(oceanAudioVolume);
                  if(isOcean && !oceanPlayer.playing){
                    oceanPlayer.play();
                  }
                }
                else{
                  oceanPlayer.setVolume(0);
                }
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Icon(isMuted ? Icons.volume_off : Icons.volume_up, color: Color(0x33ffffff),)),
              ),
            )
          )
        ],
      ),
    );
  }
}