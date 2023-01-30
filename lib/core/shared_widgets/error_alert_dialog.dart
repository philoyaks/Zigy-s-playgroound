import 'package:flutter/material.dart';

showErrorAlertDialog(BuildContext context, {String message = ''}) => showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Error Message'),
          content: Text(message),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text("Dismiss"),
            )
          ],
        );
      },
    );
