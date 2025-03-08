import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:krishidost/screens/shop/my_order_screen/my_order_screen.dart';
import 'package:krishidost/utility/extensions.dart';
import 'package:krishidost/widget/normal_appbar.dart';

import 'components/cart_product_tab.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.cartProvider.getCartItems();
      context.productListProvider.getAllOrders();
    });
  }
  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 400;
        return DefaultTabController(
          length: 2,
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: const PreferredSize(
                  preferredSize: Size.fromHeight(65),
                  child: NormalAppbar(
                    title: "My Cart",
                  )),
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    floating: true,
                    pinned: true,
                    snap: true,
                    elevation: 0,
                    expandedHeight: 60,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: LayoutBuilder(
                        builder: (context, constraints) {
                          final isSmallScreen = constraints.maxWidth < 400;
                          return TabBar(
                            labelStyle: TextStyle(
                              fontSize: isSmallScreen ? 12 : 14,
                            ),
                            tabs: [
                              CartTabs(
                                isSmallScreen: isSmallScreen,
                                title: "Cart",
                                icon: Icons.shopping_cart,
                              ),
                              CartTabs(
                                isSmallScreen: isSmallScreen,
                                title: "Orders",
                                icon: Icons.list_alt,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  const SliverFillRemaining(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        CartProductTab(),
                        MyOrderScreen(),
                      ],
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}

class CartTabs extends StatelessWidget {
  const CartTabs(
      {super.key,
      required this.isSmallScreen,
      required this.title,
      required this.icon});

  final bool isSmallScreen;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: isSmallScreen ? 20 : 28,
        ),
        const Gap(8),
        Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(
          height: double.infinity,
        )
      ],
    );
  }
}
