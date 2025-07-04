import 'package:flutter/material.dart';
import 'package:krishidost/screens/shop/product_favorite_screen/components/favorite_item.dart';
import 'package:krishidost/widget/product_Tile/product_grid_tile_two.dart';
import 'package:krishidost/widget/product_Tile/product_view_one.dart';
import 'package:krishidost/widget/product_grid_tile.dart';

import '../models/product.dart';
import '../screens/shop/product_details_screen/product_detail_screen.dart';
import '../utility/animation/open_container_wrapper.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    super.key,
    required this.items,
  });

  final List<Product> items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 260,
        crossAxisCount: 2,
        mainAxisSpacing: 6,
        crossAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        Product product = items[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product),
              ),
            );
          },
          child: ProductGridTile2(
            product: product,
            index: index,
            isPriceOff: product.offerPrice != 0,
          ),
        );
        // return OpenContainerWrapper(
        //   borderRadius: 15,
        //   color: Colors.white,
        //   nextScreen: ProductDetailScreen(product),
        //   child: ProductGridTile2(
        //     product: product,
        //     index: index,
        //     isPriceOff: product.offerPrice != 0,
        //   ),
        // );
      },
    );
  }
}
