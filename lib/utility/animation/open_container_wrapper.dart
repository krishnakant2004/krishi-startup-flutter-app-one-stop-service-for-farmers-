import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({
    super.key,
    required this.child,
    required this.nextScreen,
    required this.color,
    this.borderRadius = 30,
    this.closedBorderColor = Colors.black38,
    this.borderStyle = BorderStyle.none,
    this.elevationTrue = true,
  });

  final Widget child;
  final Widget nextScreen;
  final Color color;
  final double borderRadius;
  final Color closedBorderColor;
  final BorderStyle borderStyle;
  final bool elevationTrue;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedElevation: elevationTrue == true ? 3 : 0,
      closedShape: RoundedRectangleBorder(
        side:
            BorderSide(color: closedBorderColor, width: 1, style: borderStyle),
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
      openShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
      closedColor: color, //const Color(0xFFE5E6E8),
      transitionType: ContainerTransitionType.fade,
      transitionDuration: const Duration(milliseconds: 300),
      closedBuilder: (_, VoidCallback openContainer) {
        return InkWell(onTap: openContainer, child: child);
      },
      openBuilder: (_, __) => nextScreen,
    );
  }
}
