import 'package:flutter/material.dart';
import 'package:krishidost/utility/extensions.dart';
import 'package:krishidost/widget/product_Tile/product_view_one.dart';

import '../models/product.dart';
import '../screens/shop/product_details_screen/product_detail_screen.dart';
import '../utility/animation/open_container_wrapper.dart';

class ProductGridViewByCategory extends StatelessWidget {
  const ProductGridViewByCategory({
    super.key,
    required this.items,
    this.padding,
    this.physics,
  });

  final List<Product> items;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    // Get screen width to make adaptive calculations
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine number of columns based on screen width
    int crossAxisCount = 2;
    if (screenWidth > 600) {
      crossAxisCount = 3;
    }
    if (screenWidth > 900) {
      crossAxisCount = 4;
    }

    // Calculate appropriate aspect ratio based on testing
    // A higher aspect ratio means shorter cards
    final double aspectRatio = 0.6; // This makes cards taller

    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 20, left: 8, right: 8),
      child: GridView.builder(
        itemCount: items.length,
        shrinkWrap: true,
        physics: physics ?? const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: aspectRatio,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          Product product = items[index];
          return OpenContainerWrapper(
            borderRadius: 16,
            color: Colors.white,
            closedBorderColor: Colors.transparent,
            borderStyle: BorderStyle.none,
            nextScreen: ProductDetailScreen(product),
            child: ModernProductCard(
              index: index,
              isPriceOff: product.offerPrice != 0,
              product: product,
              onAddTap: () {
                context.productDetailProvider.addToCart(product);
              },
              onFavoriteTap: () {
                context.favoriteProvider.updateToFavoriteList(product.sId ?? " ");
              },
            ),
          );
        },
      ),
    );
  }
}