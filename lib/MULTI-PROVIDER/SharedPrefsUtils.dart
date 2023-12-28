import 'package:shared_preferences/shared_preferences.dart';

import '../UTILS/request_string.dart';
import '../UTILS/utils.dart';

class SharedPrefsUtils {
  static Future<Map<String, String>> getDefaultValuesFromPrefs() async {

    final Map<String, String> defaultValues = {
      'fullName':  await Utility.getStringValue(RequestString.NAME) ?? '',
      'email':  await Utility.getStringValue(RequestString.EMAIL) ?? '',
      'phoneNumber': await Utility.getStringValue(RequestString.PHONE_NO) ?? '',
      'dob':  await Utility.getStringValue(RequestString.DOB) ?? '',
      'gender':  await Utility.getStringValue(RequestString.GENDER) ?? '',
      'selectedImagePath': await Utility.getStringValue(RequestString.USER_IMAGE) ?? '',
    };

    print(defaultValues);

    return defaultValues;
  }
}
