class FormValidator {
  // Check if a text field is empty
  static String? validateEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is required';
    }
    return null;
  }

  // Validate an email address
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email field is empty';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
        .hasMatch(value)) {
      return 'Enter valid Email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password field is empty';
    }

    // Check if the password meets the criteria
    // For example, require at least 8 characters with at least one letter and one number
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    // Check if the password contains at least one letter
    if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
      return 'Password must contain at least one letter';
    }

    // Check if the password contains at least one number
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    // Return null if the password is valid
    return null;
  }

  static String? validateAlphabets(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }

    // Use a regular expression to check if the string contains only alphabets
    RegExp regex = RegExp(r'^[a-z A-Z ]+$');

    if (!regex.hasMatch(value)) {
      return 'Please enter only alphabets';
    }

    return null; // Validation passed
  }


  static String? validatePhoneNumber(String? value) {
    // Ensure that the phone number is not empty
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Define a regular expression for a basic phone number format
    RegExp phoneRegExp = RegExp(r'^[0-9]{10}$');

    // Check if the phone number matches the expected format
    if (!phoneRegExp.hasMatch(value) && value.length < 10) {
      return 'Invalid phone number';
    }

    // Return null if the phone number is valid
    return null;
  }

}

class PasswordValidationResult {
  final bool isValid;
  final String message;

  PasswordValidationResult(this.isValid, this.message);
}
