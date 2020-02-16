import 'package:flutter_dtx/flutter_dtx.dart';
class Example{
  void demoMethod(){
    //checks email (valid Email)
    "demo@gmail.com".isEmail();
    "#FFF".isHexColor();
    "".toHexColor();
    "".isAlpha();
    "".isFloat();
    "1234567890".isPhoneNumber();
  }
}