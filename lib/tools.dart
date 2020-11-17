class Tools {
  static capitalizeFirstWord(String value) {
    if (value == null) {
      throw ArgumentError("string: $value");
    }
    if (value.isEmpty) {
      return value;
    }
    return value[0].toUpperCase() + value.substring(1);
  }

  static capitalizeAllWords(String value) {
    if (value == null) {
      throw ArgumentError("string: $value");
    }
    if (value.isEmpty) {
      return value;
    }
    List<String> words = value.split(' ');
    String result = '';
    words.forEach((word) {
      result += word[0].toUpperCase() + word.substring(1);
      if (word == words[words.length - 1]) result += ' ';
    });
    return result;
  }

  static num simplifyDouble(double value) {
    return value == value.roundToDouble() ? value.toInt() : value;
  }

  static String getUnitShort(String unit) {
    //TODO: complete with more examples
    if (unit == 'tablespoon' || unit == 'tablespoons')
      return 'tbsp';
    else if (unit == 'teaspoon' || unit == 'teaspoons')
      return 'tsp';
    else
      return unit;
  }

  static String validatePassword(String val) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);

    return val.isEmpty
        ? 'Enter a password.'
        : val.length < 8
            ? 'Password must contain at least 8 characters.'
            : !regExp.hasMatch(val)
                ? 'At least 1: uppercase, lowercase, special character & digit.'
                : null;
  }

  static String validateEmail(String val) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(val) ? null : 'Enter a valid e-mail.';
  }
}
