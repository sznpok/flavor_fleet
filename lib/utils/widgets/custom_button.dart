import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double? borderRadius;
  final Color fgColor;
  final Color bgColor;
  final double? width;
  final VoidCallback onPressed;
  final double? height;
  final TextStyle? style;
  final double? iconSize;

  const CustomButton({
    super.key,
    required this.title,
    this.width,
    this.borderRadius = 0,
    this.fgColor = Colors.white,
    this.bgColor = Colors.orangeAccent,
    required this.onPressed,
    this.height = 0.05,
    this.style,
    this.iconSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        minimumSize: Size(
          MediaQuery.of(context).size.width * width!,
          MediaQuery.of(context).size.height * height!,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: style,
      ),
    );
  }
}
