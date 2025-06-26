import 'package:flutter/material.dart';
import 'package:map_pro/core/theme/app_color.dart';
import 'package:map_pro/view/widgets/button_widget.dart';

Future<void> showSuccessDialog(BuildContext context, String message,VoidCallback onNav) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {

      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children:
          [
            Icon(Icons.check_circle,color: AppColors.green,size: 100,),
            SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Visibility(
              visible: message.contains("Login"),
                child: ButtonWidget(buttonText: "Go to home", onSubmit:onNav))
          ],
        ),
      );
    },
  );
}
