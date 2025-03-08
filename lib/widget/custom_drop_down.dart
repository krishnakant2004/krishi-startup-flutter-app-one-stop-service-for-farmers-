import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:krishidost/utility/constants.dart';

import '../utility/app_data.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? initialValue;
  final Color? bgColor;
  final List<T> items;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final String hintText;
  final String Function(T) displayItem;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? labelColor;
  final Color? errorColor;

  const CustomDropdown({
    super.key,
    this.initialValue,
    required this.items,
    required this.onChanged,
    this.validator,
    this.hintText = 'Select an option',
    required this.displayItem,
    this.bgColor,
    this.borderColor,
    this.focusedBorderColor,
    this.labelColor,
    this.errorColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.transparent,
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<T>(
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
            isExpanded: true,
            hint: Text(
              hintText,
              style: TextStyle(
                fontSize: 16,
                color: labelColor ?? Colors.grey.shade600,
              ),
            ),
            items: items.map((T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Container(
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Text(
                      displayItem(value),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            value: initialValue,
            onChanged: onChanged,
            buttonStyleData: ButtonStyleData(
              padding: const EdgeInsets.only(left: 16, right: 8),
              height: 50,
              decoration: BoxDecoration(
                color: bgColor ?? Colors.grey[200],
                border: Border.all(
                  color: borderColor ?? Colors.grey.shade400,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.zero,
            ),
            iconStyleData: IconStyleData(
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              iconEnabledColor: focusedBorderColor ?? AppData.darkOrange,
            ),
          ),
        ),
      ),
    );
  }
}