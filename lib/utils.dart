import 'package:intl/intl.dart';

String formatDuration(Duration duration) {
  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);

  String formattedDuration = '';

  String formattedHr = formatMinAndHr(hours);
  String formattedMin = formatMinAndHr(minutes);
  String formattedSec = formatMinAndHr(seconds);

  formattedDuration = "$formattedHr:$formattedMin:$formattedSec";

  return formattedDuration.trim();
}

String formatMinAndHr(int min) {
  if (min == 0) {
    return "00";
  } else if (min < 10) {
    return "0$min";
  }

  return "$min";
}
