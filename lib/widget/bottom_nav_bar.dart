import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    super.key,
    this.height = 70,
    this.backgColor = Colors.white,
    this.selectedindex = 0,
    required this.onChanged,
  });

  final double height;
  final int selectedindex;
  final Color backgColor;
  final void Function(int index) onChanged;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgColor,
        border: const Border(top: BorderSide(color: Colors.black38,width: 0.75,)),
      ),
      child: NavigationBar(
        height: widget.height,
        backgroundColor: widget.backgColor,
        selectedIndex: widget.selectedindex,
        onDestinationSelected: widget.onChanged,
        destinations: [
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              "assets/userScreenSVG/navBar/home_fillsvg.svg",
              height: 24,
              width: 24,
              color: Colors.green,
            ),
            icon: SvgPicture.asset(
              "assets/userScreenSVG/navBar/home.svg",
              height: 24,
              width: 24,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              "assets/userScreenSVG/navBar/community_fill.svg",
              height: 28,
              width: 28,
              color: Colors.green,
            ),
            icon: SvgPicture.asset(
              "assets/userScreenSVG/navBar/community.svg",
              height: 28,
              width: 28,
              color: Colors.black,
            ),
            label: 'Community',
          ),
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              "assets/userScreenSVG/navBar/shopping_fill.svg",
              height: 28,
              width: 28,
              color: Colors.green,
            ),
            icon: SvgPicture.asset(
              "assets/userScreenSVG/navBar/shopping_cart.svg",
              height: 28,
              width: 28,
              color: Colors.black,
            ),
            label: 'Shop',
          ),
          NavigationDestination(
            selectedIcon: SvgPicture.asset(
              "assets/userScreenSVG/navBar/account_fill.svg",
              height: 28,
              width: 28,
              color: Colors.green,
            ),
            icon: SvgPicture.asset(
              "assets/userScreenSVG/navBar/account_circle.svg",
              height: 28,
              width: 28,
              color: Colors.black,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
