class Tools {
  static capitalizeString(String value) {
    if (value == null) {
      throw ArgumentError("string: $value");
    }

    if (value.isEmpty) {
      return value;
    }

    return value[0].toUpperCase() + value.substring(1);
  }
}
