class Tools {
  static String capitalizeFirstWord(String value) {
    if (value == null) {
      throw ArgumentError("string: $value");
    }
    if (value.isEmpty) {
      return value;
    }
    return value[0].toUpperCase() + value.substring(1);
  }

  static String capitalizeAllWords(String value) {
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
      if (word != words[words.length - 1]) result += ' ';
    });
    List<String> words2 = result.split('-');
    String result2 = '';
    words2.forEach((word) {
      result2 += word[0].toUpperCase() + word.substring(1);
      if (word != words2[words2.length - 1]) result2 += '-';
    });
    return result2;
  }

  static num simplifyDouble(double value) {
    return value == value.roundToDouble() ? value.toInt() : value;
  }

  static String getUnitShort(String unitLong) {
    String unit = unitLong.endsWith('s') ? unitLong.substring(0, unitLong.length - 1) : unitLong;

    if (unit.toLowerCase() == 'tablespoon' || unit == 'T')
      return 'tbsp';
    else if (unit.toLowerCase() == 'teaspoon' || unit == 't')
      return 'tsp';
    else if (unit.toLowerCase() == 'c')
      return 'cup';
    else if (unit.toLowerCase() == 'gram')
      return 'g';
    else if (unit.toLowerCase() == 'millilitre' || unit == 'mL')
      return 'ml';
    else if (unit == 'ounce')
      return 'oz';
    else
      return unit.toLowerCase();
  }

  static String getDate(DateTime date) {
    String day = date.day < 10 ? '0${date.day}' : '${date.day}';
    String month = date.month < 10 ? '0${date.month}' : '${date.month}';
    return '$day-$month-${date.year}';
  }

  static String getImageName(String val) {
    return val.replaceAll(RegExp(' +'), '-').toLowerCase() + '.jpg';
  }

  static String validatePassword(String val) {
    Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
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
