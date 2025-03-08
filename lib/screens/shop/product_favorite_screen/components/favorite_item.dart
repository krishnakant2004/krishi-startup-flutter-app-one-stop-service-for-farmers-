import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:krishidost/models/product.dart';
import 'package:krishidost/screens/shop/product_details_screen/components/product_rating_section.dart';
import 'package:krishidost/utility/animation/open_container_wrapper.dart';
import 'package:krishidost/utility/extensions.dart';
import 'package:krishidost/utility/utility_extension.dart';
import 'package:krishidost/utility/snack_bar_helper.dart';
import 'package:krishidost/widget/custom_network_image.dart';
import 'package:krishidost/screens/shop/product_details_screen/product_detail_screen.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final productImage = product.images
        ?.safeElementAt(0)
        ?.url ?? " ";
    double discountPercentage = context.productListProvider
        .calculateDiscountPercentage(
            product.price ?? 0, product.offerPrice ?? 0);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child:Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        OpenContainerWrapper(
                            borderRadius: 12,
                            nextScreen: ProductDetailScreen(product),
                            color: Colors.white,
                            child:
                            ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            height: 120,
                            width: 120,
                            child: CustomNetworkImage(
                              imageUrl:productImage,
                              fit: BoxFit.cover,
                              scale: 1.0,
                            ),
                          ),
                        ),
                        ),
                        if (discountPercentage != 0)
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
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
                      ],
                    ),
                    const Gap(22),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                            const Gap(4),
                            const ProductRatingSection(
                              alloTouchFunctionality: true,
                              itemSize: 14,
                            ),
                            const Gap(8),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    product.offerPrice != 0
                                        ? "₹${product.offerPrice}"
                                        : "₹${product.price}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: Colors.green.shade800,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Gap(3),
                                if (product.offerPrice != null &&
                                    product.offerPrice != product.price)
                                  Flexible(
                                    child: Text(
                                      "₹${product.price}",
                                      style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                              ],
                            ),
                            const Gap(8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                              ),
                              onPressed: () {
                                context.productDetailProvider.addToCart(product);
                              },
                              child: const Text(
                                "Add to Cart",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
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

          ),
          const Gap(8),
          InkWell(
            splashColor: Colors.red,
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              context.favoriteProvider.updateToFavoriteList(product.sId ?? '');
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
