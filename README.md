# flutter_dtx

**Dart utils Extension functions**
  Flutter package for Basic dart extension functions.


## Usage
* To use this package

```yaml
dev_dependencies:
  flutter_dtx:
```


 **String Extenstions**


 1. **isEmail()** check whether the string is valid email or not
 2. **isPhoneNumber()** check whether the string is valid phone number
 3. **isAlpha()** return true if there is only alphabets in string
 4.  **isAlphaNumeric()**  return true if there is only alphabets and numeric (no special chars $%^&*)
 5. **isNumeric()** return true if there is only numeric values in string eg 12345 or 1.22
 6. **isInt()** return true if string is valid integer eg 123
 7. **isFloat()** return true if string is valid floating value eg 1.2
 8. **isHexColor()**  return true if string is valid hexadecimal color code
 9. **toInt()** parse string to Int
 10. **toDouble()** parse string to Double
 11. **toHexColor()** parse string hexadecimal color to color object
 12. **capitalize()** Capitalize the string eg flutter to Flutter
 13. **deCapitalize()** Decapitalize the string eg Flutter to flutter
 14. **log()** For Logging calls print()
 15. **jsonDecode()** Parse string to Json map<String,Dynamic>
 16. **toDate(String format)** parse String to DateTime
 17. **formatDateStringToUTC(String inputPattern,String outputPattern)** format StringDate UTC StringDate
 18. **changeDateStringFormat(String inputPattern,String outputPattern)** changes the date format
 19. **formatDateStringToLocal(String inputPattern,String outputPattern)** parse StringDate toLocal date
 20. **toCharsList()** convert String to list of Chars
 21. **chunk()** divide String to List<String>
 22. **replaceChars(int start,int end,String delimiter)** replace chars from start to end with delimeter eg 12345****10
 23. **insert(int steps, String valueToInsert)** insert string in after specify chars[steps]
 24. **equalsIgnorecase(String compareTo)** compare string in case Insensitive manner

 **Int Extensions**

 1. **getDateFromMillis()** pares int to DateTime (int should be millis)
 2. **timeAgoString()** returns ago time based on Millis

 **Context Extensions**

 1. **navigateTo(Widget destinationWidget, {bool isPushReplace = false)** redirect to other screen which passed as widget
 2. **hideKeyboard()** hide a keyboard if showing on screen
 3. **getDeviceSize()** return a screen size
 4. **popScreen()** pops the screen with context


