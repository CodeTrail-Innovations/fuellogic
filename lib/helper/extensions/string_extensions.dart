import 'package:intl/intl.dart';

extension FirebaseErrorMessage on String {
  String get readableAuthError {
    final error = this;

    if (error.contains('invalid-credential') || error.contains('wrong-password')) {
      return 'Invalid email or password';
    } else if (error.contains('user-not-found')) {
      return 'No account found with this email';
    } else if (error.contains('email-already-in-use')) {
      return 'An account already exists with this email';
    } else if (error.contains('weak-password')) {
      return 'Password is too weak. Please use a stronger password';
    } else if (error.contains('invalid-email')) {
      return 'Please enter a valid email address';
    } else if (error.contains('network-request-failed')) {
      return 'Network error. Please check your internet connection';
    } else if (error.contains('too-many-requests')) {
      return 'Too many attempts. Please try again later';
    } else {
      return 'An error occurred. Please try again';
    }
  }
}


String formatWithSuffix(DateTime dt) {
  final day = dt.day;
  String suffix;
  if (day >= 11 && day <= 13) {
    suffix = 'th';
  } else {
    switch (day % 10) {
      case 1:
        suffix = 'st';
        break;
      case 2:
        suffix = 'nd';
        break;
      case 3:
        suffix = 'rd';
        break;
      default:
        suffix = 'th';
    }
  }
  final month = DateFormat('MMMM').format(dt);
  final year = dt.year;
  final time = DateFormat('h:mm a').format(dt);
  return '$day$suffix $month, $year  –  $time';
}