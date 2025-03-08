import 'package:gap/gap.dart';
import 'package:krishidost/entry_app/login.dart';
import 'package:krishidost/utility/extensions.dart';

import '../../../models/product.dart';
import '../../../widget/horizontal_list.dart';
import 'provider/product_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widget/carousel_slider.dart';
import '../../../../widget/page_wrapper.dart';
import 'components/product_rating_section.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    bool isExpanded = false;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          height: 48,
          width: 48,
          margin: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: PageWrapper(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(35),
              //? product image section
              CarouselSlider(
                items: product.images ?? [],
                boxFit: BoxFit.contain,
                scale: 1.0,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //? product name
                    Text(
                      '${product.name}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    //? product rating section
                    const ProductRatingSection(),
                    const SizedBox(height: 10),
                    //? product rate , offer , stock section
                    Row(
                      children: [
                        Text(
                          product.offerPrice != null
                              ? "\$${product.offerPrice}"
                              : "\$${product.price}",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(width: 3),
                        Visibility(
                          visible: product.offerPrice != product.price,
                          child: Text(
                            "\$${product.price}",
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          product.quantity != 0
                              ? "Available stock : ${product.quantity}"
                              : "Not available",
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    product.proVariantId!.isNotEmpty
                        ? Text(
                            'Available ${product.proVariantTypeId?.type}',
                            style: const TextStyle(
                                color: Colors.red, fontSize: 16),
                          )
                        : const SizedBox(),
                    Consumer<ProductDetailProvider>(
                      builder: (context, proDetailProvider, child) {
                        return HorizontalList(
                          items: product.proVariantId ?? [],
                          itemToString: (val) => val,
                          onSelect: (val) {
                            proDetailProvider.selectedVariant =
                                product.proVariantId![val];
                            proDetailProvider.updateUI();
                          },
                        );
                      },
                    ),
                    //? product description
                    Text(
                      'About',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10),
                    StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.description ?? '',
                              maxLines: isExpanded ? null : 3,
                              overflow: isExpanded
                                  ? TextOverflow.visible
                                  : TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              child: Text(
                                isExpanded ? 'Read Less' : 'Read More',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                    //? add to cart button
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      //? add to cart button
      floatingActionButton: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ElevatedButton(
            onPressed: product.quantity != 0
                ? () {
              context.productDetailProvider.addToCart(product);
                  }
                : null,
            child: const Text("Add to cart",
                style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
