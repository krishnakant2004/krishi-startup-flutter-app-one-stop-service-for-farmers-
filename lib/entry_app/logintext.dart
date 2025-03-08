import 'package:flutter/material.dart';

class LoginText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? opacity;
  final Color? color;

  const LoginText({
    super.key,
    required this.text,
    this.fontSize = 16, // Default value for fontSize
    this.fontWeight = FontWeight.normal, // Default value for fontWeight
    this.opacity = 1.0, // Default value for opacity
    this.color = Colors.white, // Default value for color
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color!.withOpacity(opacity!), // Ensure opacity is applied
        fontSize: fontSize, // Use fontSize variable
        fontWeight: fontWeight, // Use fontWeight variable
      ),
      textAlign: TextAlign.center, // Center the text
    );
  }
}