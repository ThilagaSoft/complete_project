import 'package:flutter/material.dart';
import 'package:map_pro/core/theme/text_styles.dart';

class ButtonWidget extends StatelessWidget {
  String buttonText;
  VoidCallback onSubmit;
   ButtonWidget({super.key, required this.buttonText, required this.onSubmit});

  @override
  Widget build(BuildContext context)
  {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onSubmit,
        style: ElevatedButton.styleFrom(
          padding:
          const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child:  Text(buttonText,style: TextStyles.buttonText,),
      ),
    );
  }
}
