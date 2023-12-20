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
    return DateFormat('dd/MM/yy').format(_selectedDate);
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}
