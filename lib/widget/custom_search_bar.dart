import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  CustomSearchBarState createState() => CustomSearchBarState();
}

class CustomSearchBarState extends State<CustomSearchBar> {
  bool isExpanded = true;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
          if (!isExpanded) {
            _focusNode.unfocus();
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),

        child: FocusScope(
          node: FocusScopeNode(),
          child: Row(
            children: [
              const Icon(Icons.search),
              const Gap(10),
              Expanded(
                child: TextField(
                  focusNode: _focusNode,
                  controller: widget.controller,
                  decoration: const InputDecoration(
                    hintText: 'search product here',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.normal),
                  ),
                  autofocus: false,
                  // onChanged: widget.onChanged,
                  onSubmitted:  widget.onChanged,
                ),
              ),
              GestureDetector(
                onTap: () {
                  widget.controller.clear();
                  _focusNode.unfocus();
                },
                child: const Icon(Icons.close,color: Colors.black54,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
