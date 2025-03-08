import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:krishidost/utility/extensions.dart';

import '../../../../widget/custom_search_bar.dart';

class SearchFilterBar extends StatefulWidget {
  const SearchFilterBar({super.key});

  @override
  State<SearchFilterBar> createState() => _SearchFilterBarState();
}

class _SearchFilterBarState extends State<SearchFilterBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double iconSize = size.width * 0.057;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: CustomSearchBar(
              controller: TextEditingController(),
              onChanged: (val) {
                context.productListProvider.filterProducts(val);
              },
            ),
          ),
          const Gap(6),
          Container(
            constraints: const BoxConstraints(maxWidth: 45, maxHeight: 45),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(12),
            child: const Icon(
              Icons.filter_alt_outlined,
              color: Colors.black87,
              // size: iconSize,
            ),
          ),
          const Gap(5),
        ],
      ),
    );
  }
}
