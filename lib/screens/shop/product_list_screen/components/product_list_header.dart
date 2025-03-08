import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:krishidost/screens/shop/product_favorite_screen/favorite_screen.dart';
import 'package:krishidost/screens/shop/product_list_screen/components/search_filter_bar.dart';

import '../../../../utility/app_data.dart';
import '../../../../utility/constants.dart';
import '../../product_cart_screen/cart_screen.dart';

class LikeHeartBagHeader extends StatelessWidget
    implements PreferredSizeWidget {
  final double silverAppbarSize;
  @override
  Size get preferredSize => const Size.fromHeight(120);
  const LikeHeartBagHeader({super.key, required this.silverAppbarSize});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double horizontalPadding = size.width * 0.025; // Dynamic padding
    double iconSize = silverAppbarSize * 0.3; // Dynamic icon size
    double fontSize = silverAppbarSize * 0.18;

    return Container(
      width: size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            //  Color(0xff01452c),
            Color(0xff025839),
            Color(0xff026c45),
            Color(0xff03925e),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "welcome,",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white // Dynamic font size
                                  ),
                          // softWrap: true,
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Krishnakant Dinkar",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.white // Dynamic font size
                                    ),
                            // softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Gap(4),
                      IconWithNotification(
                        onTap: null,
                        iconPath:
                            "assets/Buyproduct/notification-bell-line-svgrepo-com.svg",
                        iconSize: iconSize,
                      ),
                      Gap(size.width * 0.05), // Dynamic gap
                      IconWithNotification(
                        iconPath: "assets/Buyproduct/heart-svgrepo-com (1).svg",
                        iconSize: iconSize,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavoriteScreen(),
                          ),
                        ),
                      ),
                      Gap(size.width * 0.05), // Dynamic gap
                      IconWithNotification(
                        iconPath:
                            "assets/Buyproduct/shopping-bag-5-1-svgrepo-com.svg",
                        iconSize: iconSize,
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        )),
                      ),
                    ],
                  ),
                ],
              ),
              const SearchFilterBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class IconWithNotification extends StatelessWidget {
  const IconWithNotification({
    super.key,
    required this.iconPath,
    this.onTap,
    this.iconSize = 20,
    this.isVisible=false,
  });

  final String iconPath;
  final VoidCallback? onTap;
  final double iconSize;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.width * 0.11,
        width: size.width * 0.11,
        constraints: const BoxConstraints(maxHeight: 44, maxWidth: 44),
        decoration: const BoxDecoration(
          color: AppData.lightGrey,
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            Center(
              child: SvgPicture.asset(
                iconPath,
                height: iconSize,
                width: iconSize,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).iconTheme.color!,
                  BlendMode.srcIn,
                ),
              ),
            ),
           Visibility(
             visible: isVisible,
             child:  Positioned(
             top: iconSize * 0,
             right: iconSize * 0.04,
             child: Container(
               decoration: const BoxDecoration(
                 shape: BoxShape.circle,
                 color: Colors.red,
               ),
               child: const Padding(
                 padding: EdgeInsets.all(4.0),
                 child: Center(
                   child: Text(
                     "2",
                     style: TextStyle(color: Colors.white),
                   ),
                 ),
               ),
             ),
           ),)
          ],
        ),
      ),
    );
  }
}
