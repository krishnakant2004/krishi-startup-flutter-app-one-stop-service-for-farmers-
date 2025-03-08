import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:krishidost/main.dart';
import 'package:krishidost/utility/extensions.dart';
import 'package:krishidost/widget/circular_container.dart';
import 'package:krishidost/widget/custom_search_bar.dart';

import '../../../../utility/app_data.dart';
import '../../product_cart_screen/cart_screen.dart';

class ProductByCategaryAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final String selectedCategory;
  const ProductByCategaryAppbar({super.key, required this.selectedCategory});

  @override
  Size get preferredSize => const Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 8),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            selectedCategory,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Row(
            children: [
              const Gap(2),
              CircularContainer(
                height: 50,
                width: 50,
                color: Colors.white,
                child: IconButton(
                    onPressed: () {
                      context.productByCategoryProvider.sortByPriceDropDownValue = "Sort By Price";
                      Navigator.pop(context);
                    },

                    icon: const Icon(
                      Icons.arrow_back,
                      size: 25,
                    )),
              ),
              const Gap(2),
              Expanded(
                child: CustomSearchBar(
                  controller: TextEditingController(),
                  onChanged: (val) {
                    context.productByCategoryProvider.filterProductByName(val);
                  },
                ),
              ),
              const Gap(2),
              CircularContainer(
                width: 50,
                height: 50,
                child: IconButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CartScreen())),
                  icon: SvgPicture.asset(
                    "assets/Buyproduct/shopping-bag-5-1-svgrepo-com.svg",
                    height: 30,
                    width: 30,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).iconTheme.color!,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
