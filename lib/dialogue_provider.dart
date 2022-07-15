import 'package:flutter/material.dart';
import 'package:ps/res/res.dart';

class DialogueProvider extends ChangeNotifier{

  bool _isInputVisible = false;
  bool _isTalkVisible = false;
  bool fixedAnim = false;
  int _talkCounter = 0;
  String _currentTalk = '';

  init(){
    //Strings.talks.shuffle();
    //print(Strings.talks);
  }

  toggleInputVisibility(){
    _isInputVisible = !_isInputVisible;
    notifyListeners();
  }

  toggleTalkVisibility(){
    _isTalkVisible = !_isTalkVisible;
    notifyListeners();
  }

  fixTween(bool b){
    fixedAnim = b;
    notifyListeners();
  }

  talk(){
    toggleInputVisibility();
    if(!_isTalkVisible && !fixedAnim){
      fixTween(true);
      _currentTalk = Strings.talks[_talkCounter];
      _talkCounter += 1;
      if(_talkCounter == Strings.talks.length){
        _talkCounter = 0;
      }
      toggleTalkVisibility();
    }
  }

  String getCurrentTalk(){
    return _currentTalk;
  }

  bool getIsInputVisible(){
    return _isInputVisible;
  }

  bool getIsTalkVisible(){
    return _isTalkVisible;
  }

}