import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:krishidost/screens/profile_screen/my_profile_screen/Profile.dart';
import '../widget/bottom_nav_bar.dart';
import '../widget/page_wrapper.dart';
import 'shop/product_list_screen/product_list_screen.dart';
import 'community/community.dart';
import 'home/Home.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});
  static const List<Widget> screens = [
    Home(),
    Community(),
    BuyProductScreen(),
    ProfileScreen(),
  ];
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: Scaffold(
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return FadeThroughTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: UserScreen.screens[_selectedindex],
        ),
        bottomNavigationBar: CustomBottomNavBar(
            height: 70,
            selectedindex: _selectedindex,
            onChanged: (index) {
              setState(() {
                _selectedindex = index;
              });
            }),
      ),
    );
  }
}

/// Inner Style Indicators Banner Slider
