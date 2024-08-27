// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.buttonLoading,
    required this.text,
    required this.onPressed,
    this.enabled = true,
    this.expanded = true,
    this.textColor = Colors.white,
    this.backgroundColor = const LinearGradient(
      colors: [
        Color(0xff6CC5FF),
        Color.fromARGB(255, 154, 231, 161),
      ],
    ),
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  });

  final bool buttonLoading;
  final Color textColor;
  final String text;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final bool enabled;
  final LinearGradient? backgroundColor;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    Widget button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: buttonLoading
            ? const EdgeInsets.symmetric(vertical: 5, horizontal: 20)
            : padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
      onPressed: buttonLoading || !enabled
          ? null
          : () {
              HapticFeedback.selectionClick();
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
        children: [Expanded(child: _buildGradientContainer(button))],
      );
    } else {
      return _buildGradientContainer(button);
    }
  }

  Widget _buildGradientContainer(Widget button) {
    return Container(
      decoration: BoxDecoration(
        gradient: backgroundColor, 
        borderRadius: BorderRadius.circular(12), 
      ),
      child: button,
    );
  }
}

class LoadingButtonV2 extends StatefulWidget {
  final bool buttonLoading;
  final String text;
  final VoidCallback onPressed;
  final SvgPicture? icon;
  final Color backgroundColor;

  const LoadingButtonV2({
    super.key,
    required this.buttonLoading,
    required this.text,
    required this.onPressed,
    this.icon,
    required this.backgroundColor,
  });

  @override
  // ignore: library_private_types_in_public_api
  _LoadingButtonV2State createState() => _LoadingButtonV2State();
}

class _LoadingButtonV2State extends State<LoadingButtonV2> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.buttonLoading ? null : widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        disabledForegroundColor: Colors.grey.withOpacity(0.38),
        disabledBackgroundColor:
            Colors.grey.withOpacity(0.12), // Color when button is disabled
      ),
      child: widget.buttonLoading
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.icon != null) ...[
                  widget.icon!,
                  const SizedBox(width: 8),
                ],
                Text(widget.text),
              ],
            ),
    );
  }
}
