import 'package:flutter/material.dart';
import 'package:ps/res/res.dart';

class DialogueProvider extends ChangeNotifier{

  bool _isInputVisible = false;
  bool _isQuestionVisible = false;
  bool _isTalkVisible = false;
  bool fixedAnim = false;
  bool isInputAnimOver = false;
  bool isQuestionAnimOver = false;
  int _talkCounter = 0;
  String _currentTalk = '';

  init(){
    //Strings.talks.shuffle();
    //print(Strings.talks);
  }

  toggleInputVisibility(){
    _isInputVisible = !_isInputVisible;
    Future.delayed(Duration(seconds: 1), (){
      isInputAnimOver = !isInputAnimOver;
    });
    notifyListeners();
  }

  toggleQuestionVisibility(){
    _isQuestionVisible = !_isQuestionVisible;
    Future.delayed(Duration(seconds: 1), (){
      isQuestionAnimOver = !isQuestionAnimOver;
    });
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

  // click on hitbox for input -- only if done talking
  dialogue(){
    if(!getIsTalkVisible()){
      if(!_isQuestionVisible){
        toggleInputVisibility();
      }
      else{
        toggleQuestionVisibility();
      }
    }
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

  ask(){
    toggleInputVisibility();
    Future.delayed(Duration(seconds: 1), (){
      toggleQuestionVisibility();
    });
  }

  answer(String s){
    toggleQuestionVisibility();
    if(!_isTalkVisible && !fixedAnim){
      fixTween(true);
      _currentTalk = s;
      toggleTalkVisibility();
    }
  }

  comment(String s){
    if(!_isTalkVisible && !fixedAnim){
      fixTween(true);
      _currentTalk = s;
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

  bool getIsQuestionVisible(){
    return _isQuestionVisible;
  }

}