import 'package:flutter/material.dart';
import '../view/widgets/error_dialog_widget.dart';

void ExceptionHelper(BuildContext context, int? errorCode) {
  showDialog(
    context: context,
    builder: (context) => ErrorDialog(
      title: 'Error',
      message: getErrorMessage(errorCode),
    ),
  );
}

String getErrorMessage(int? errorCode) {
  switch (errorCode) {
    case 400:
      return 'Bad request. Please check your request parameters.';
    case 401:
      return 'Unauthorized. Please log in again.';
    case 404:
      return 'Not found. The resource you requested does not exist.';
    default:
      return 'An error occurred. Please try again later.';
  }
}