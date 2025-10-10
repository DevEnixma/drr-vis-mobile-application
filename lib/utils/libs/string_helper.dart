import 'package:intl/intl.dart';

import '../../app/config/server_config.dart';

class StringHleper {
  static List<String> findErrorCodes(String input) {
    final RegExp errorCodePattern = RegExp(r'\b(401|Unauthorized)\b');
    final Iterable<Match> matches = errorCodePattern.allMatches(input);

    return matches.map((match) => match.group(0)!).toList();
  }

  static List<String> splitData(String value, keySplit) {
    return value.split(keySplit);
  }

  static String convertDDMMYYYYToDDMM(String dateString) {
    // String dateString = '15/10/2566';

    // แปลง พ.ศ. เป็น ค.ศ.
    List<String> dateParts = dateString.split('/');
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]) - 543; // แปลงปี พ.ศ. เป็น ค.ศ.

    // สร้าง DateTime
    DateTime dateTime = DateTime(year, month, day);
    return convertToDDMM(dateTime);
  }

  static String convertToDDMM(DateTime dateTime) {
    String formattedDate = DateFormat('dd/MM').format(dateTime);
    return formattedDate;
  }

  static String checkString(dynamic value) {
    if (value == null) {
      return '-';
    } else {
      return '${value.toString() != '' ? value : '-'}';
    }
  }

  static int stringToInt(dynamic value) {
    if (value == null || value != '' || value == 'null') {
      return 0;
    } else {
      return int.parse(value);
    }
  }

  static String stringToDouble(dynamic value) {
    if (value != null && value != '') {
      return value;
    } else {
      return '0';
    }
  }

  static String numberAddComma(String value) {
    return value.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ','); // ใส่เครื่องหมายคั่นหลัก
  }

  static String convertStringToKilo(dynamic value) {
    if (value == null || value.toString() == '') {
      return '-';
    }

    double number = double.parse(value); // แปลง string เป็น double
    int result = (number * 1000).toInt(); // คูณด้วย 1000 และแปลงเป็น int
    String formattedResult = numberAddComma(result.toString());

    return formattedResult;
  }

  static String convertStringToKiloWithOutComma(dynamic value) {
    if (value == null || value.toString() == '') {
      return '-';
    }

    double number = double.parse(value); // แปลง string เป็น double
    int result = (number * 1000).toInt(); // คูณด้วย 1000 และแปลงเป็น int

    return result.toString();
  }

  static double convertStringToKiloWithOutCommaDouble(dynamic value) {
    double number = double.parse(value); // แปลง string เป็น double
    int result = (number * 1000).toInt(); // คูณด้วย 1000 และแปลงเป็น int

    return double.parse(result.toString());
  }

  static String sumText(String input, b) {
    double result = 0;
    if (input != '') {
      result = double.parse(input);
    }

    result += double.parse(b);
    return result.toString();
  }

  static String numberStringCutComma(String value) {
    return value.replaceAll(',', '');
  }

  static String doubleToStringComma(String number) {
    double value = double.tryParse(number) ?? 0.0;

    final formatter = NumberFormat('#,##0.00');
    return formatter.format(value);
  }

  static String convertTimeThai(String value) {
    // "01/08/2567  16:35:06";
    value = value.replaceAll(RegExp(r'\s+'), ' ');

    DateFormat inputFormat = DateFormat("dd/MM/yyyy HH:mm:ss");
    DateTime dateTime = inputFormat.parse(value);

    DateTime gregorianDate = DateTime(
      dateTime.year,
      // dateTime.year - 543,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
    );

    int hour = gregorianDate.hour;
    print('Extracted hour: $hour');

    DateFormat outputFormat = DateFormat("d MMMM yyyy HH:mm", 'th');
    String formattedDate = outputFormat.format(gregorianDate);

    return formattedDate;
  }

  static String convertTimeFormat(String value) {
    // "01/08/2567  16:35:06";
    value = value.replaceAll(RegExp(r'\s+'), ' ');

    DateFormat inputFormat = DateFormat("dd/MM/yyyy HH:mm:ss");
    DateTime dateTime = inputFormat.parse(value);

    DateTime gregorianDate = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
    );

    int hour = gregorianDate.hour;
    print('Extracted hour: $hour');

    DateFormat outputFormat = DateFormat("d MMMM yyyy HH:mm", 'th');
    String formattedDate = outputFormat.format(gregorianDate);

    return formattedDate;
  }

  static String CheckPartUrlImage(String value) {
    final pattern = r'^(http|https)://';
    final regex = RegExp(pattern);

    if (regex.hasMatch(value)) {
      return value;
    } else {
      return '${ServerConfig.baseUrlImage}${value}';
    }
  }

  static String convertFormatYearTh(DateTime dateTime, String formatResponse) {
    dateTime = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
    );

    DateFormat dateFormat = DateFormat(formatResponse, 'th_TH');
    String formattedDate = dateFormat.format(dateTime).replaceAll(
          (dateTime.year).toString(),
          (dateTime.year + 543).toString(),
        );

    return formattedDate;
  }

  static String convertDateThai(String value, formatType) {
    // "01/08/2567";
    value = value.replaceAll(RegExp(r'\s+'), ' ');

    DateFormat inputFormat = DateFormat("dd/MM/yyyy");
    DateTime dateTime = inputFormat.parse(value);
    dateTime = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
    );

    DateTime gregorianDate = DateTime(
      dateTime.year,
      // dateTime.year - 543,
      dateTime.month,
      dateTime.day,
    );

    int hour = gregorianDate.hour;
    print('Extracted hour: $hour');

    DateFormat outputFormat = DateFormat(formatType, 'th_TH');
    String formattedDate = outputFormat.format(gregorianDate);

    return formattedDate;
  }
}
