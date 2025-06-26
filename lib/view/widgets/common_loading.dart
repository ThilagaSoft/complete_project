import 'package:flutter/material.dart';

class LoadingDialog {
  static void show(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 20),
                Flexible(
                  child: Text(
                    message ?? 'Loading...',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context); // Close the dialog
    }
  }
}
