import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DateProvider extends ChangeNotifier {
  late DateTime _selectedDate;

  DateTime get selectedDate => _selectedDate;

  DateProvider() {
    _selectedDate = DateTime.now();
  }

  String get formattedSelectedDate {
    // Format the date as DD/MM/YY
    return DateFormat('yyyy-MM-dd').format(_selectedDate);
  }

  String formattedDate(DateTime date) {
    // Format the date as DD/MM/YY
    return DateFormat('dd-MM-yyyy').format(date);
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void resetState() {
    // Reset the state to its initial values
    _selectedDate = DateTime.now();
    notifyListeners();
  }
}
