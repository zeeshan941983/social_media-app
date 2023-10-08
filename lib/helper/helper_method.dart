import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formattedData(Timestamp timestamp) {
  DateTime now = DateTime.now();
  DateTime postTime = timestamp.toDate();
  Duration difference = now.difference(postTime);

  if (difference.inDays >= 30) {
    // If the post is more than a month old, display the whole date
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(postTime);
  } else if (difference.inHours >= 1) {
    // If the post is at least 1 hour old but less than a month old, display it in hours
    int hoursAgo = difference.inHours;
    return '$hoursAgo ${hoursAgo == 1 ? 'hour' : 'hr'} ago';
  } else if (difference.inMinutes >= 1) {
    // If the post is at least 1 minute old but less than an hour old, display it in minutes
    int minutesAgo = difference.inMinutes;
    return '$minutesAgo ${minutesAgo == 1 ? 'minute' : 'min'} ago';
  } else {
    // If the post is less than 1 minute old, display it in seconds
    int secondsAgo = difference.inSeconds;
    return '$secondsAgo ${secondsAgo == 1 ? 'second' : 'sec'} ago';
  }
}
