library flutter_dtx;

import 'dart:collection';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import "package:flutter/widgets.dart";
import 'package:intl/intl.dart';

extension StringExtenstions on String {
  //Validation function

  /// check whether the string is valid email or not
  bool isEmail() => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);

  /// check whether the string is valid phone number
  bool isValidPhoneNumber({Country validInCountry}) {
    if(this.length>= validInCountry.minLength && this.length<=validInCountry.maxLength){
      return true;
    }
    return false;
  }

  ///return true if there is only alphabets in string
  bool isAlpha() => RegExp(r'^[a-zA-Z]+$').hasMatch(this);

  ///return true if there is only alphabets and numeric (no special chars $%^&*)
  bool isAlphaNumeric() => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);

  ///return true if there is only numeric values in string eg 12345 or 1.22
  bool isNumeric() => RegExp(r'^-?[0-9]+$').hasMatch(this);

  ///return true if string is valid integer eg 123
  bool isInt() => RegExp(r'^(?:-?(?:0|[1-9][0-9]*))$').hasMatch(this);

  ///return true if string is valid floating value eg 1.2
  bool isFloat() =>
      RegExp(r'^(?:-?(?:[0-9]+))?(?:\.[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?$')
          .hasMatch(this);

  ///return true if string is valid hexadecimal color code
  bool isHexColor() =>
      RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$').hasMatch(this);

  //Conversion function

  ///parse string to Int
  int toInt() => int.parse(this);

  ///parse string to Double
  double toDouble() => double.parse(this);

  ///parse string hexadecimal color to color object
  Color toHexColor() =>
      new Color(int.parse(this.substring(1, 7), radix: 16) + 0xFF000000);

  ///Capitalize the string eg flutter to Flutter
  String capitalize() => (this != null && this.length > 1)
      ? this[0].toUpperCase() + this.substring(1)
      : this != null ? this.toUpperCase() : null;

  ///Decapitalize the string eg Flutter to flutter
  String deCapitalize() => (this != null && this.length > 1)
      ? this[0].toLowerCase() + this.substring(1)
      : this != null ? this.toLowerCase() : null;

  ///For Logging calls print()
  void log() => print(this);

  ///parse string to Json map<String,Dynamic>
  Map<String, dynamic> toJsonMap() => jsonDecode(this);

  ///String revers
  String revers() => String.fromCharCodes(this.runes.toList().reversed);

  //date time utils

  ///parse String to DateTime
  DateTime toDate({@required String format}) => DateFormat(format).parse(this);

  ///format StringDate UTC StringDate
  String formatDateStringToUTC(
      {@required String inputPattern, String outputPattern}) {
    if (outputPattern == null || outputPattern.isEmpty)
      outputPattern = inputPattern;
    return DateFormat(outputPattern)
        .format(DateFormat(inputPattern).parse(this).toUtc());
  }

  ///changes the date formate
  String changeDateStringFormat(
      {@required String inputPattern, @required String outputPattern}) {
    return DateFormat(outputPattern)
        .format(DateFormat(inputPattern).parse(this));
  }

  ///parse StringDate toLocal date
  String formatDateStringToLocal(
      {@required String inputPattern, String outputPattern}) {
    if (outputPattern == null || outputPattern.isEmpty)
      outputPattern = inputPattern;
    return DateFormat(outputPattern)
        .format(DateFormat(inputPattern).parse(this).toLocal());
  }

  ///convert String to list of Chars
  List<String> toCharsList() {
    List<String> arr = [];
    this.runes.forEach((int rune) {
      arr.add(String.fromCharCode(rune));
    });
    return arr;
  }

  ///divide String to List<String>
  List<String> chunks(int sizeOfChunks) {
    List<String> chunks = [];
    List charList = this.toCharsList();
    int len = charList.length;
    for (var i = 0; i < len; i += sizeOfChunks) {
      int size = i + sizeOfChunks;
      chunks.add((charList.sublist(i, size > len ? len : size)).join());
    }
    return chunks;
  }

  ///replace chars from start to end with delimeter eg 12345****10
  String replaceChars(
      {int start = 0, @required int end, String delimiter = "*"}) {
    StringBuffer buffer = StringBuffer();
    int counter = 0;
    this.runes.forEach((int rune) {
      if (counter >= start && counter <= end) {
        buffer.write(delimiter);
      } else {
        buffer.write(String.fromCharCode(rune));
      }
      counter++;
    });
    return buffer.toString();
  }

  ///insert string in after specify chars[steps]
  String insert({int steps, String valueToInsert}) {
    StringBuffer buffer = StringBuffer();
    int counter = 0;
    this.runes.forEach((int rune) {
      if (counter == steps) {
        buffer.write(valueToInsert);
        counter = 0;
      }
      buffer.write(String.fromCharCode(rune));
      counter++;
    });
    return buffer.toString();
  }

  ///compare string in case Insensitive manner
  bool equalsIgnorecase(String compareTo) =>
      this.toLowerCase() == compareTo.toLowerCase();
}

extension IntExtension on int {
  ///pares int to DateTime (int should be millis)
  DateTime getDateFromMillis() {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }

  ///returns ago time based on Millis
  String timeAgoString({bool numericDates = true}) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(this);
    final date2 = DateTime.now();
    final difference = date2.difference(date);
    if ((difference.inDays / 365).floor() >= 2)
      return '${(difference.inDays / 365).floor()} years ago';
    else if ((difference.inDays / 365).floor() >= 1)
      return (numericDates) ? '1 year ago' : 'Last year';
    else if ((difference.inDays / 30).floor() >= 2)
      return '${(difference.inDays / 365).floor()} months ago';
    else if ((difference.inDays / 30).floor() >= 1)
      return (numericDates) ? '1 month ago' : 'Last month';
    else if ((difference.inDays / 7).floor() >= 2)
      return '${(difference.inDays / 7).floor()} weeks ago';
    else if ((difference.inDays / 7).floor() >= 1)
      return (numericDates) ? '1 week ago' : 'Last week';
    else if (difference.inDays >= 2)
      return '${difference.inDays} days ago';
    else if (difference.inDays >= 1)
      return (numericDates) ? '1 day ago' : 'Yesterday';
    else if (difference.inHours >= 2)
      return '${difference.inHours} hours ago';
    else if (difference.inHours >= 1)
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    else if (difference.inMinutes >= 2)
      return '${difference.inMinutes} minutes ago';
    else if (difference.inMinutes >= 1)
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    else if (difference.inSeconds >= 3)
      return '${difference.inSeconds} seconds ago';
    else
      return 'Just now';
  }
}


extension ContextExtension on BuildContext {
  ///redirect to other screen which passed as widget
  void navigateTo(Widget destinationWidget, {bool isPushReplace = false}) {
    if (isPushReplace) {
      Navigator.pushReplacement(
        this,
        MaterialPageRoute(builder: (context) => destinationWidget),
      );
      return;
    }
    Navigator.push(
      this,
      MaterialPageRoute(builder: (context) => destinationWidget),
    );
  }

  ///hide a keyboard if showing on screen
  void hideKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }

  ///return a screen size
  Size getDeviceSize() {
    return MediaQuery.of(this).size;
  }

  ///pops the screen with context
  void popScreen() {
    Navigator.pop(this);

  }
}
extension on Object{
  String getEnumName(){
    return this.toString().split(".").last;
  }
}

///date time formates
//    ICU Name                   use formate
//    --------                   --------
//    DAY                          d
//    ABBR_WEEKDAY                 E
//    WEEKDAY                      EEEE
//    ABBR_STANDALONE_MONTH        LLL
//    STANDALONE_MONTH             LLLL
//    NUM_MONTH                    M
//    NUM_MONTH_DAY                Md
//    NUM_MONTH_WEEKDAY_DAY        MEd
//    ABBR_MONTH                   MMM
//    ABBR_MONTH_DAY               MMMd
//    ABBR_MONTH_WEEKDAY_DAY       MMMEd
//    MONTH                        MMMM
//    MONTH_DAY                    MMMMd
//    MONTH_WEEKDAY_DAY            MMMMEEEEd
//    ABBR_QUARTER                 QQQ
//    QUARTER                      QQQQ
//    YEAR                         y
//    YEAR_NUM_MONTH               yM
//    YEAR_NUM_MONTH_DAY           yMd
//    YEAR_NUM_MONTH_WEEKDAY_DAY   yMEd
//    YEAR_ABBR_MONTH              yMMM
//    YEAR_ABBR_MONTH_DAY          yMMMd
//    YEAR_ABBR_MONTH_WEEKDAY_DAY  yMMMEd
//    YEAR_MONTH                   yMMMM
//    YEAR_MONTH_DAY               yMMMMd
//    YEAR_MONTH_WEEKDAY_DAY       yMMMMEEEEd
//    YEAR_ABBR_QUARTER            yQQQ
//    YEAR_QUARTER                 yQQQQ
//    HOUR24                       H
//    HOUR24_MINUTE                Hm
//    HOUR24_MINUTE_SECOND         Hms
//    HOUR                         j
//    HOUR_MINUTE                  jm
//    HOUR_MINUTE_SECOND           jms
//    HOUR_MINUTE_GENERIC_TZ       jmv
//    HOUR_MINUTE_TZ               jmz
//    HOUR_GENERIC_TZ              jv
//    HOUR_TZ                      jz
//    MINUTE                       m
//    MINUTE_SECOND                ms
//    SECOND                       s


///Country phone Validation
class PhoneNumberUtil{
    HashMap countryMap= HashMap<String,Country>();
   static PhoneNumberUtil instance=PhoneNumberUtil._();
   static Country benin,burkinafaso,capeverde,cameroon,canada,china,cotedivoire,egypt,finland,france,gambia,germany,ghana,greece,guineabissau,guinea,india,italy,japan,kenya,liberia,libya,malawi,malaysia,mali,mauritania,morocco,niger,nigeria,northkorea,russia,saudiarabia,senegal,sierraleone,southafrica,southkorea,spain,sweden,switzerland,togo,ukraine,unitedarabemirate,unitedkingdom,unitedstates;

   static List<Country> getAllCountry(){
     return instance.countryMap.values;
   }
   PhoneNumberUtil._(){
     initMap();
   }
    void initMap(){
     countryMap["BJ"]=benin=Country("Benin Republic","BJ",229,8,8);
     countryMap["BF"]=burkinafaso=Country("Burkina Faso","BF",226,8,8);
     countryMap["CV"]=capeverde=Country("Cape Verde","CV",238,7,7);
     countryMap["CM"]=cameroon=Country("Cameroon","CM",237,8,8);
     countryMap["CA"]=canada=Country("Canada","CA",1,10,10);
     countryMap["CN"]=china=Country("China","CN",86,11,11);
     countryMap["CI"]=cotedivoire=Country("Cote d'Ivoire","CI",225,8,8);
     countryMap["EG"]=egypt=Country("Egpyt","EG",20,9,10);
     countryMap["FI"]=finland=Country("Finland","FI",358,6,11);
     countryMap["FR"]=france=Country("France","FR",33,9,9);
     countryMap["GM"]=gambia=Country("Gambia","GM",220,7,7);
     countryMap["DE"]=germany=Country("Germany","DE",49,7,12);
     countryMap["GH"]=ghana=Country("Ghana","GH",233,9,9);
     countryMap["GR"]=greece=Country("Greece","GR",30,10,10);
     countryMap["GW"]=guineabissau=Country("Guinea Bissau","GW",245,7,7);
     countryMap["GN"]=guinea=Country("Guinea","GN",224,8,9);
     countryMap["IN"]=india=Country("India","IN",91,10,10);
     countryMap["IT"]=italy=Country("Italy","IT",39,9,10);
     countryMap["JP"]=japan=Country("Japan","JP",81,10,10);
     countryMap["KE"]=kenya=Country("Kenya","KE",254,9,9);
     countryMap["LR"]=liberia=Country("Liberia","LR",231,7,9);
     countryMap["LY"]=libya=Country("Libya","LY",218,9,9);
     countryMap["MW"]=malawi=Country("Malawi","MW",265,9,9);
     countryMap["MY"]=malaysia=Country("Malaysia","MY",60,9,10);
     countryMap["ML"]=mali=Country("Mali","ML",223,8,8);
     countryMap["MR"]=mauritania=Country("Mauritania","MR",222,8,8);
     countryMap["MA"]=morocco=Country("Morocco","MA",212,9,9);
     countryMap["NE"]=niger=Country("Niger","NE",227,8,8);
     countryMap["NG"]=nigeria=Country("Nigeria","NG",234,10,10);
     countryMap["KP"]=northkorea=Country("North Korea","KP",850,10,10);
     countryMap["RU"]=russia=Country("Russia","RU",7,10,10);
     countryMap["SA"]=saudiarabia=Country("Saudi Arabia","SA",966,9,9);
     countryMap["SN"]=senegal=Country("Senegal","SN",221,9,9);
     countryMap["SL"]=sierraleone=Country("Sierra Leone","SL",232,8,8);
     countryMap["ZA"]=southafrica=Country("South Africa","ZA",27,9,9);
     countryMap["KR"]=southkorea=Country("South Korea","KR",82,9,10);
     countryMap["ES"]=spain=Country("Spain","ES",34,9,9);
     countryMap["SE"]=sweden=Country("Sweden","SE",46,9,9);
     countryMap["CH"]=switzerland=Country("Switzerland","CH",41,9,9);
     countryMap["TG"]=togo=Country("Togo","TG",228,8,8);
     countryMap["UA"]=ukraine=Country("Ukraine","UA",380,9,9);
     countryMap["AE"]=unitedarabemirate=Country("United Arab Emirate","AE",971,10,10);
     countryMap["GB"]=unitedkingdom=Country("United Kingdom","GB",44,10,10);
     countryMap["US"]=unitedstates=Country("United States","US",1,10,10);
   }
}

class Country {
  PhoneNumberUtil xu=PhoneNumberUtil._();
  String name, iso;
  int countryCode, maxLength, minLength;
  Country(this.name,  this.iso, this.countryCode,this.minLength,  this.maxLength);

}