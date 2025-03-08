import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:krishidost/widget/custom_network_image.dart';

import '../../../../models/category.dart';
import '../../product_by_category_screen/product_by_category_screen.dart';

class CategorySelector extends StatelessWidget {
  final List<Category> categories;
  final double silverSize;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.silverSize,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Container(
          padding: const EdgeInsets.only(bottom: 0, top: 6, left: 2, right: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 2),
                  shape: BoxShape.circle,
                ),
                height: 60,
                width: 60,
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductByCategoryScreen(
                            selectedCategory: category,
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: CustomNetworkImage(
                        imageUrl: category.image ?? " ",
                        fit: BoxFit.cover,
                        scale: 1,
                      ),
                    )),
                // child: OpenContainerWrapper(
                //   color: Colors.grey[200] ?? const Color(0xFFE5E6E8),
                //   borderRadius: 60,
                //   nextScreen: ProductByCategoryScreen(
                //     selectedCategory: category,
                //   ),
                //   child: CustomNetworkImage(
                //     imageUrl: imageUrl,
                //     fit: BoxFit.cover,
                //     scale: 1,
                //   ),
                // ),
              ),
              const Gap(4),
              SizedBox(
                width: 70, // Constrain width
                child: Text(
                  category.name ?? '',
                  textAlign: TextAlign.center,
                  maxLines: 2, // Limit to one line
                  overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
