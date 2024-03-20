import 'package:intl/intl.dart';

String formatDateTime(DateTime postTimeStamp) {
  final now = DateTime.now();
  final difference = now.difference(postTimeStamp);

  if (difference < const Duration(seconds: 5)) {
    return 'just now';
  } else if (difference < const Duration(minutes: 1)) {
    return '${difference.inSeconds} seconds ago';
  } else if (difference < const Duration(minutes: 2)) {
    return '1 minute ago';
  } else if (difference < const Duration(hours: 1)) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference < const Duration(hours: 2)) {
    return '1 hour ago';
  } else if (difference < const Duration(days: 1)) {
    return '${difference.inHours} hours ago';
  } else if (difference < const Duration(days: 2)) {
    return '1 day ago';
  } else if (difference < const Duration(days: 30)) {
    return '${difference.inDays} days ago';
  } else {
    final formattedDate = DateFormat('MMM dd, yyyy').format(postTimeStamp);
    return formattedDate;
  }
}