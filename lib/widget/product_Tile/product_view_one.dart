import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:krishidost/screens/shop/product_favorite_screen/provider/favorite_provider.dart';
import 'package:krishidost/utility/constants.dart';
import 'package:krishidost/utility/extensions.dart';
import 'package:krishidost/utility/utility_extension.dart';
import 'package:krishidost/widget/custom_network_image.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../utility/app_data.dart';

class ModernProductCard extends StatelessWidget {
  final Product product;
  final int index;
  final bool isPriceOff;
  final Function()? onAddTap;
  final Function()? onFavoriteTap;

  const ModernProductCard({
    super.key,
    required this.index,
    required this.isPriceOff,
    required this.product,
    this.onAddTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final discountPercentage =
    context.productListProvider.calculateDiscountPercentage(
      product.price ?? 0,
      product.offerPrice ?? 0,
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section with discount badge and favorite button
            Stack(
              children: [
                // Product image - Flexible height based on available space
                AspectRatio(
                  aspectRatio: 1.4, // Width:Height ratio
                  child: CustomNetworkImage(
                    imageUrl: product.images
                        ?.safeElementAt(0)
                        ?.url ?? " ",
                    fit: BoxFit.cover,
                  ),
                ),

                // Discount badge
                if (discountPercentage != 0)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppData.darkGreen,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${discountPercentage.toInt()}% OFF",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),

                // Favorite button
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: onFavoriteTap,
                      icon: Consumer<FavoriteProvider>(
                        builder: (context, provider, child) {
                          return Icon(
                            Icons.favorite,
                            color: context.favoriteProvider
                                .checkIsItemFavorite(product.sId ?? '')
                                ? Colors.red
                                : Colors.grey[400],
                            size: 24,
                          );
                        },
                      ),
                      constraints: const BoxConstraints(
                        minHeight: 36,
                        minWidth: 36,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),

            // Product details - Flexible content that fits available space
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product name
                    Text(
                      product.name!.isNotEmpty ? product.name ?? "" : "",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(2),
                    // Product description - Optional, shows only if there's space
                    Flexible(
                      child: Text(
                        product.description!.isNotEmpty
                            ? product.description ?? ""
                            : "",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const Gap(10),

                    // Price section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Offer price
                        Text(
                          product.offerPrice != 0
                              ? "₹${product.offerPrice}"
                              : "₹${product.price}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF222222),
                          ),
                        ),

                        const Gap(6),

                        // Original price (if discounted)
                        if (product.offerPrice != null &&
                            product.offerPrice != product.price)
                          Flexible(
                            child: Text(
                              "₹${product.price}",
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),

                    // Add to cart button - Always at the bottom
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onAddTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1565C0),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          minimumSize: const Size.fromHeight(30),
                        ),
                        child: const Text(
                          "ADD TO CART",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
