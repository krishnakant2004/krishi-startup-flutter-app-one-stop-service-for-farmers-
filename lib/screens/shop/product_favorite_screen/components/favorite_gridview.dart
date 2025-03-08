import 'package:flutter/material.dart';
import 'package:krishidost/screens/shop/product_favorite_screen/components/favorite_item.dart';
import 'package:krishidost/utility/snack_bar_helper.dart';
import '../../../../models/product.dart';

class FavoriteGridview extends StatelessWidget {
  const FavoriteGridview({
    super.key,
    required this.items,
  });

  final List<Product> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      shrinkWrap: true,
      itemBuilder: (context, index){
          return FavoriteItem(product: items[index]);},
    );
  }
}
