import 'dart:async';

import 'package:brew_crew/screens/authenticate/login.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {    
    Timer(Duration(seconds: 1),()=>{
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Wrapper()))
    });
  }
}
