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

  static String? validatePhoneNumber(String? value) {
    // Ensure that the phone number is not empty
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Define a regular expression for a basic phone number format
    RegExp phoneRegExp = RegExp(r'^[0-9]{10}$');

    // Check if the phone number matches the expected format
    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number';
    }

    // Return null if the phone number is valid
    return null;
  }

  static String? validatePassword(String? password) {
    // Define a regular expression pattern for a strong password
    //final passwordPattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[\W_]).{8,}$';
    final passwordPattern = r'^(?=.*[a-z]).{8,}$';

    // Create a regular expression object
    final regExp = RegExp(passwordPattern);

    if (password == null || password.isEmpty) {
      return 'Password cannot be empty.';
    } else if (!regExp.hasMatch(password)) {
      return 'Password should be strong minimum length 8';
    }
    return null;
  }
}

class PasswordValidationResult {
  final bool isValid;
  final String message;

  PasswordValidationResult(this.isValid, this.message);
}
