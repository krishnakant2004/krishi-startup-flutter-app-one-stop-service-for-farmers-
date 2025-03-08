import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:krishidost/utility/utility_extension.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../screens/shop/product_favorite_screen/provider/favorite_provider.dart';
import '../utility/extensions.dart';
import 'circular_container.dart';
import 'custom_network_image.dart';

class ProductGridTile extends StatelessWidget {
  final Product product;
  final int index;
  final bool isPriceOff;

  const ProductGridTile({
    super.key,
    required this.product,
    required this.index,
    required this.isPriceOff,
  });

  @override
  Widget build(BuildContext context) {
    final productImage = product.images
            ?.safeElementAt(0)
            ?.url ??
        '';
    double discountPercentage = context.productListProvider
        .calculateDiscountPercentage(
            product.price ?? 0, product.offerPrice ?? 0);

    // Getting screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjusting size based on screen width
    double headerHeight = screenHeight * 0.15;
    double footerHeight = screenHeight * 0.11;
    double imageSize = screenWidth * 0.35; // Dynamic image size

    return GridTile(
      header: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: discountPercentage != 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey.withOpacity(0.3),
                  border: Border.all(color: Colors.black38),
                ),
                //width: , // Dynamic width
                height: 34, // Dynamic height
                alignment: Alignment.center,
                child: Text(
                  "OFF ${discountPercentage.toInt()} %",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14, // Dynamic font size
                  ),
                ),
              ),
            ),
            Consumer<FavoriteProvider>(
              builder: (context, favoriteProvider, child) {
                return IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: context.favoriteProvider.checkIsItemFavorite(product.sId ?? '')
                        ? Colors.red
                        : Colors.grey.withOpacity(0.8),
                    size: 36,
                  ),
                  onPressed: () {
                    context.favoriteProvider
                        .updateToFavoriteList(product.sId ?? '');
                  },
                );
              },
            ),
          ],
        ),
      ),
      footer: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Container(
          padding: const EdgeInsets.all(6),
          //height: footerHeight, // Dynamic height for footer
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                  fontSize: screenWidth * 0.04, // Dynamic font size
                ),
              ),
              const Gap(3),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      product.offerPrice != 0
                          ? "\$${product.offerPrice}"
                          : "\$${product.price}",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: screenWidth * 0.045), // Dynamic font size
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Gap(3),
                  if (product.offerPrice != null &&
                      product.offerPrice != product.price)
                    Flexible(
                      child: Text(
                        "\$${product.price}",
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
              const Gap(4),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.add,
                                size: 18,
                              ),
                              Expanded(
                                  child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "cart",
                                        style: TextStyle(fontSize: 18),
                                      )))
                            ],
                          )),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: const Text(
                            "Buy Now",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                      ),
                      onTap: () {}, // ontap
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(
            left: 8, right: 8, bottom: 125, top: 0), //screenWidth * 0.14
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10)),
          child: CustomNetworkImage(
            imageUrl: product.images!.isNotEmpty ? productImage : '',
            fit: BoxFit.cover,
            scale: 1.0,
          ),
        ),
      ),
    );
  }
}
