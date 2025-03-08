import 'package:flutter/material.dart';
import 'package:krishidost/main.dart';
import 'package:krishidost/screens/shop/product_cart_screen/components/cart_list_section.dart';
import 'package:krishidost/screens/shop/product_cart_screen/provider/cart_provider.dart';
import 'package:krishidost/utility/extensions.dart';
import 'package:provider/provider.dart';
import '../../../../models/product.dart';
import 'buy_now_bottom_sheet.dart';
import 'cart_item.dart';
import 'empty_cart.dart';

class CartProductTab extends StatelessWidget {
  const CartProductTab({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 400;

        return Consumer<CartProvider>(
          builder: (context, cartprovider, child) {
            return Column(
              children: [
                cartprovider.myCartItems.isEmpty
                    ? const EmptyCart()
                    : CartListSection(
                        cartProducts: context.cartProvider.myCartItems),
                _buildCheckoutSection(isSmallScreen, context),
              ],
            );
          },
        );
      },
    );
  }
}

Widget _buildCheckoutSection(bool isSmallScreen, BuildContext context) {
  return Container(
    padding: EdgeInsets.all(
        isSmallScreen ? 16 : 20), // More padding for better spacing
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20)), // Rounded top corners
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3), // Softer shadow
          spreadRadius: 2,
          blurRadius: 10,
          offset: const Offset(0, -3), // Slightly larger offset
        ),
      ],
    ),
    child: SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(
                  fontSize: isSmallScreen ? 18 : 20, // Slightly larger font
                  fontWeight: FontWeight.bold,
                  color:
                      Colors.grey.shade800, // Darker text for better contrast
                ),
              ),
              Text(
                '₹${context.cartProvider.getCartSubTotal()}',
                style: TextStyle(
                  fontSize: isSmallScreen ? 18 : 20, // Slightly larger font
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context)
                      .primaryColor, // Use primary color for emphasis
                ),
              ),
            ],
          ),
          SizedBox(height: isSmallScreen ? 16 : 20), // More spacing
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: isSmallScreen
                      ? 14
                      : 18, // More padding for a larger button
                ),
                backgroundColor:
                    Theme.of(context).primaryColor, // Use primary color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    12,
                  ), // Rounded corners for the button
                ),
                elevation: 2, // Subtle elevation
                shadowColor: Colors.black.withOpacity(0.2), // Soft shadow
              ),
              onPressed: context.cartProvider.myCartItems.isEmpty
                  ? null
                  : () {
                      showCustomBottomSheet(context);
                    },
              child: Text(
                'Buy Now',
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18, // Slightly larger font
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text for better contrast
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
