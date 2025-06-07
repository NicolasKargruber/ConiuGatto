import 'package:flutter/material.dart';

import 'extensions/build_context_extensions.dart';

class ErrorSnackbar {
  static show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: context.colorScheme.onErrorContainer),),
        behavior: SnackBarBehavior.floating,
        backgroundColor: context.colorScheme.errorContainer,
        action: SnackBarAction(
          label: 'Close',
          textColor: context.colorScheme.onErrorContainer,
          onPressed: () {
            // Code to execute.
          },
        ),
      ),
    );
  }
}