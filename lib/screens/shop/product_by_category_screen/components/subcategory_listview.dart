import 'package:flutter/material.dart';
import 'package:krishidost/main.dart';
import 'package:krishidost/utility/extensions.dart';
import 'package:provider/provider.dart';

import '../../../../models/brand.dart';
import '../../../../models/sub_category.dart';
import '../../../../widget/custom_drop_down.dart';
import '../../../../widget/horizontal_list.dart';
import '../../../../widget/multi_selected_drop_down.dart';
import '../provider/product_by_category_provider.dart';

class SubcategoryListview extends StatelessWidget {
  const SubcategoryListview({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<ProductByCategoryProvider>(
              builder: (context, proByCatProvider, child) {
                return HorizontalList(
                  items: proByCatProvider.subCategories,
                  itemToString: (SubCategory? val) => val?.name ?? '',
                  onSelect: (val) {
                    context.productByCategoryProvider
                        .filterProductBySubCategory(val);
                  },
                );
              },
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Consumer<ProductByCategoryProvider>(
                      builder: (context, provider, child) {
                        return CustomDropdown<String>(
                          bgColor: Colors.white,
                          hintText: context.productByCategoryProvider.sortByPriceDropDownValue,
                          items: const ['Low To High', 'High To Low'],
                          onChanged: (val) {
                            if (val?.toLowerCase() == 'low to high') {
                              context.productByCategoryProvider
                                  .sortProduct(ascending: true);
                            } else {
                              context.productByCategoryProvider
                                  .sortProduct(ascending: false);
                            }
                          },
                          displayItem: (val) => val,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Consumer<ProductByCategoryProvider>(
                      builder: (context, proByCatProvider, child) {
                        return MultiSelectDropDown<Brand>(
                          hintText: 'Filter By Brands',
                          items: proByCatProvider.brands,
                          onSelectionChanged: (val) {
                            proByCatProvider.selectedBrands = val;
                            context.productByCategoryProvider
                                .filterProductByBrand();
                            proByCatProvider.updateUI();
                          },
                          displayItem: (val) => val.name ?? '',
                          selectedItems: proByCatProvider.selectedBrands,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}