import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.buttonLoading,
    required this.text,
    required this.onPressed,
    this.enabled = true,
    this.expanded = true,
    this.textColor = Colors.white,
    this.backgroundColor = const Color.fromARGB(255, 83, 192, 10),
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  });

  final bool buttonLoading;
  final Color textColor;
  final String text;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final bool enabled;
  final Color backgroundColor;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    Widget button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: buttonLoading
            ? const EdgeInsets.symmetric(vertical: 5, horizontal: 20)
            : padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              12), // Set the radius here for rounded corners
        ),
      ),
      onPressed: buttonLoading || !enabled
          ? null
          : () {
              HapticFeedback.lightImpact();
              onPressed();
            },
      child: buttonLoading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: textColor,
                strokeWidth: 2,
              ),
            )
          : Text(
              text,
              style: TextStyle(color: textColor),
            ),
    );

    if (expanded) {
      return Row(
        children: [Expanded(child: button)],
      );
    } else {
      return button;
    }
  }
}
