import 'package:flutter/material.dart';

TextStyle HintTextTextStyle() => TextStyle(
      color: Colors.black.withOpacity(0.4),
    );

class TextFeildAuth extends StatefulWidget {
  TextFeildAuth({
    Key? key,
    required this.text,
    this.secure = false,
    this.isSuffixShow = false,
    required this.controller,
    required this.prefixIcon,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  final String text;
  bool secure;
  final bool isSuffixShow;
  final TextEditingController controller;
  final Icon prefixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  @override
  State<TextFeildAuth> createState() => _TextFeildAuthState();
}

class _TextFeildAuthState extends State<TextFeildAuth> {
  bool _hasError = false;

  void toggleIsShow() {
    setState(() {
      widget.secure = !widget.secure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.secure,
        onChanged: (value) {
          if (widget.validator != null) {
            setState(() {
              _hasError = widget.validator!(value) != null;
            });
          }
          widget.onChanged?.call(value);
        },
        validator: widget.validator,
        decoration: InputDecoration(
          hintText: widget.text,
          hintStyle: HintTextTextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: _hasError ? colorScheme.error : colorScheme.outline,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: _hasError ? colorScheme.error : colorScheme.outline,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: _hasError ? colorScheme.error : colorScheme.primary,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: colorScheme.error,
            ),
          ),
          suffixIcon: widget.isSuffixShow
              ? IconButton(
                  onPressed: toggleIsShow,
                  icon: Icon(
                    widget.secure ? Icons.visibility_off : Icons.visibility,
                    color: colorScheme.primary,
                  ),
                )
              : null,
          prefixIcon: widget.prefixIcon,
          fillColor: Colors.white.withOpacity(0.9),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
