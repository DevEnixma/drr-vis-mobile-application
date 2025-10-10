import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class ConvertDate {
  static DateTime stringToDateYYYYMMDD(String value) {
    // yyyy-MM-dd
    return DateTime.parse(value);
  }

  static String convertDateToYYYYDDMM(DateTime value) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(value);
  }

  static String convertDateToDDMMMMYYYY(DateTime value) {
    return convertFormatYearTh(value, 'dd MMMM yyyy');
  }

  static String convertDateToDDMMMMYYYYHHmm(String value) {
    DateTime dateTime = DateTime.parse(value);
    // final DateFormat formatter = DateFormat('dd MMMM yyyy HH:mm');
    // return formatter.format(dateTime);

    return convertFormatYearTh(dateTime, 'dd MMMM yyyy HH:mm');
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

  static String dateTimeSubtractDays(int dayAmount) {
    return Jiffy.now().subtract(days: dayAmount).format(pattern: 'dd/MM/yyyy');
  }

  static String dateTimeSubtractDaysV2(int dayAmount) {
    return Jiffy.now().subtract(days: dayAmount).format(pattern: 'yyyy-MM-dd');
  }

  static DateTime dateTimeSubstract(DateTime dateTime, int amount) {
    return dateTime.subtract(Duration(days: amount));
  }

  static DateTime dateTimeYearSubstract(DateTime currentDate, int amount) {
    return DateTime(
      currentDate.year - amount,
      currentDate.month,
      currentDate.day,
      currentDate.hour,
      currentDate.minute,
      currentDate.second,
      currentDate.millisecond,
      currentDate.microsecond,
    );
  }

  static DateTime dateTimeYearAdd(DateTime currentDate, int amount) {
    return DateTime(
      currentDate.year + amount,
      currentDate.month,
      currentDate.day,
      currentDate.hour,
      currentDate.minute,
      currentDate.second,
      currentDate.millisecond,
      currentDate.microsecond,
    );
  }
}
