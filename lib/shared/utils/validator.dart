class Validator {
  Validator._();

  static String? validateName(String? value) {
    // Remove leading and trailing white spaces

    if (value!.length <= 2) {
      return 'Please enter at least 3 characters';
    }

    return null; // Return null if the full name is valid
  }

  static String? validatePrice(String? value) {
    // Remove leading and trailing white spaces

    if (value!.isEmpty) {
      return 'Please enter a price';
    }

    return null; // Return null if the full name is valid
  }

  static String? validateNumberRange(double? fund, int min, int max) {
    if (fund == null) {
      return null;
    }
    if (fund < min || fund > max) {
      return 'Should be between $min and $max';
    }
    // You can add more specific password validation rules here

    return null;
  }

  static String? validateEmptyOrMaxiMin(String? value, int min, int max) {
    // Remove leading and trailing white spaces
    if (value!.isEmpty) {
      return null;
    }
    if (value.length < min) {
      return 'Please enter at least $min characters';
    }
    if (value.length > max) {
      return 'Please enter at most $max characters';
    }

    return null; // Return null if the full name is valid
  }

  static String? validateMaxiMin(String? value, int min, int max) {
    // Remove leading and trailing white spaces
    if (value!.length < min) {
      return 'Please enter at least $min character(s)';
    }
    if (value.length > max) {
      return 'Please enter at most $max characters';
    }

    return null; // Return null if the full name is valid
  }
}
