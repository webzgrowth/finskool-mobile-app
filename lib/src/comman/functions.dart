import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class CommonFunctions {
  static double getHeight(
      {required BuildContext context, required double height}) {
    return MediaQuery.of(context).size.height * height;
  }

  static double getWidth(
      {required BuildContext context, required double width}) {
    return MediaQuery.of(context).size.width * width;
  }

  static String formatDate(int microsecondsSinceEpoch) {
    // Convert microseconds to DateTime
    final date = DateTime.fromMillisecondsSinceEpoch(microsecondsSinceEpoch);

    // Define the desired format: '10 Jan, 2024'
    final DateFormat formatter = DateFormat('d MMM, y');

    // Return the formatted date
    return formatter.format(date);
  }
}
