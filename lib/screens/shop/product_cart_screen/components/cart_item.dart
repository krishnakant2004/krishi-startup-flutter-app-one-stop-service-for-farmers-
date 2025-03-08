import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:krishidost/entry_app/login.dart';
import 'package:krishidost/screens/shop/product_details_screen/product_detail_screen.dart';
import 'package:krishidost/utility/animation/open_container_wrapper.dart';
import 'package:krishidost/utility/extensions.dart';
import 'package:krishidost/utility/utility_extension.dart';
import 'package:krishidost/widget/custom_network_image.dart';

import '../../../../models/product.dart';

class CartItem extends StatelessWidget {
  CartItem({super.key, required this.product});

  final Product product;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 400;

        return Card(
          elevation: 0.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 8 : 16,
            vertical: 8,
          ),
          child: Padding(
            padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OpenContainerWrapper(
                  elevationTrue: false,
                  nextScreen: ProductDetailScreen(product),
                  color: Colors.white,
                  borderRadius: 12,
                  child: Container(
                    width: isSmallScreen ? 80 : 120,
                    height: isSmallScreen ? 80 : 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CustomNetworkImage(
                        imageUrl: product.images!.isNotEmpty
                            ? product.images?.safeElementAt(0)?.url ?? ''
                            : '',
                        fit: BoxFit.cover,
                        scale: 1.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: isSmallScreen ? 12 : 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.name.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 15 : 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '\$${product.price!.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 16 : 18,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: ItemIncrementDecrement(
                                isSmallScreen: isSmallScreen, quantity: 1),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // context.cartProvider.removeItem(cartItem)
                  },
                  icon: Icon(Icons.close,
                      size: isSmallScreen ? 20 : 22,
                      color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ItemIncrementDecrement extends StatefulWidget {
  ItemIncrementDecrement({
    super.key,
    required this.isSmallScreen,
    required this.quantity,
  });

  final bool isSmallScreen;
  int quantity;

  @override
  State<ItemIncrementDecrement> createState() => _ItemIncrementDecrementState();
}

class _ItemIncrementDecrementState extends State<ItemIncrementDecrement> {
  void increase() {
    setState(() {
      widget.quantity++;
    });
  }

  void decrease() {
    setState(() {
      if (widget.quantity > 0) {
        widget.quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: decrease,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Icon(
              Icons.remove,
              size: widget.isSmallScreen ? 16 : 18,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Container(
          constraints: BoxConstraints(minWidth: widget.isSmallScreen ? 30 : 36),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '${widget.quantity}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: widget.isSmallScreen ? 14 : 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        InkWell(
          onTap: increase,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Icon(
              Icons.add,
              size: widget.isSmallScreen ? 16 : 18,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
