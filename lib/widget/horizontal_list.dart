import 'package:flutter/material.dart';
import 'package:krishidost/utility/extensions.dart';

class HorizontalList<T> extends StatelessWidget {
  final List<T>? items;
  final String Function(T) itemToString;
  final void Function(int) onSelect;
  final Color? selectedColor;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  const HorizontalList({
    super.key,
    this.items,
    required this.itemToString,
    required this.onSelect,
    this.selectedColor,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    if (items!.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items?.length ?? 0,
          itemBuilder: (context, index) {
            T item = items![index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: FilterChip(
                label: Text(
                  itemToString(item),
                  style: TextStyle(
                    color: context.productByCategoryProvider.isSubCategorySelected[index]
                        ? Colors.white
                        : textColor ?? Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onSelected: (bool selected) {
                  onSelect(index);
                },
                selected: context.productByCategoryProvider.isSubCategorySelected[index],
                selectedColor: selectedColor ?? Theme.of(context).primaryColor,
                showCheckmark: true,
                checkmarkColor: Colors.white,
                backgroundColor: backgroundColor ?? Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: borderColor ?? Colors.grey.shade400,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                shadowColor: Colors.black.withOpacity(0.1),
              ),
            );
          },
        ),
      ),
    );
  }
}