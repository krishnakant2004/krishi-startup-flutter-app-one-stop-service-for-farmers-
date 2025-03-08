import 'package:krishidost/entry_app/login.dart';
import 'package:krishidost/screens/shop/product_favorite_screen/provider/favorite_provider.dart';
import 'package:krishidost/utility/extensions.dart';
import 'package:krishidost/utility/utility_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:krishidost/widget/custom_network_image.dart';
import 'package:provider/provider.dart';

class CartListSection extends StatelessWidget {
  final List<CartModel> cartProducts;

  const CartListSection({
    super.key,
    required this.cartProducts,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: cartProducts.mapWithIndex((index, _) {
            CartModel cartItem = cartProducts[index];
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          color: Colors
                              .primaries[index % Colors.primaries.length]
                              .withOpacity(0.1),
                          child: CustomNetworkImage(imageUrl: cartItem.productImages.safeElementAt(0) ?? " " ,width: 80,
                            height: 80,),
                          // child: Image.network(
                          //   cartItem.productImages.safeElementAt(0)?.replaceAll(
                          //           'localhost', '172.16.108.25') ??
                          //       '',
                          //   fit: BoxFit.cover,
                          //   loadingBuilder: (context, child, loadingProgress) {
                          //     if (loadingProgress == null) return child;
                          //     return Center(
                          //       child: CircularProgressIndicator(
                          //         value: loadingProgress.expectedTotalBytes !=
                          //                 null
                          //             ? loadingProgress.cumulativeBytesLoaded /
                          //                 loadingProgress.expectedTotalBytes!
                          //             : null,
                          //       ),
                          //     );
                          //   },
                          //   errorBuilder: (context, error, stackTrace) {
                          //     return const Icon(Icons.error, color: Colors.red);
                          //   },
                          // ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Product Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItem.productName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              cartItem.productDetails,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₹${cartItem.variants.safeElementAt(0)?.price}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Additional Features: Favorite and Remove Buttons
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Consumer<FavoriteProvider>(
                                      builder: (context, provider, child) {
                                        return IconButton(
                                          onPressed: () {
                                            context.favoriteProvider
                                                .updateToFavoriteList(
                                                    cartItem.productId);
                                          },
                                          icon: context.favoriteProvider
                                                  .checkIsItemFavorite(
                                                      cartItem.productId)
                                              ? Icon(
                                                  Icons.favorite,
                                                  color: Colors.red[600],
                                                  size: 20,
                                                )
                                              : Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.grey[600],
                                                  size: 20,
                                                ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      onPressed: () {
                                       context.cartProvider.removeItem(cartItem);
                                      },
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: Colors.grey[600],
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                // Quantity Controls
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          context.cartProvider
                                              .updateCart(cartItem, -1);
                                        },
                                        icon: const Icon(Icons.remove,
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        '${cartItem.quantity}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          context.cartProvider
                                              .updateCart(cartItem, 1);
                                        },
                                        icon: const Icon(Icons.add,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
