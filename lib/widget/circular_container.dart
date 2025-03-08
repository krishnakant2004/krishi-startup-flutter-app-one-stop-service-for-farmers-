import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key,
    this.width=40,
    this.height=40,
    this.marginVal=0,
    this.paddingVal=0,
    this.color=Colors.white,
    required this.child
  });

  final child;
  final double height;
  final double width;
  final Color color;
  final double paddingVal;
  final double marginVal;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.all(marginVal),
      padding: EdgeInsets.all(paddingVal),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child:child,
    );
  }
}
