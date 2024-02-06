import 'package:flutter/material.dart';
import '../UTILS/app_color.dart';

class MyProgressBar extends StatefulWidget {
  final double progress;

  MyProgressBar({Key? key, required this.progress}) : super(key: key);

  @override
  _MyProgressBarState createState() => _MyProgressBarState();
}

class _MyProgressBarState extends State<MyProgressBar> {
  late double _progress;

  @override
  void initState() {
    super.initState();
    _progress = widget.progress;

    // Example: Delayed update after 1 second
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _progress = widget.progress; // Set your desired progress value here
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: _progress,
      backgroundColor: hintColor,
      valueColor: AlwaysStoppedAnimation<Color>(btnbgColor),
    );
  }
}
