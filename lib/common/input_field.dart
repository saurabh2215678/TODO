import 'package:flutter/material.dart';
class input_field extends StatelessWidget {
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  final bool? enabled;
  const input_field({Key? key, this.keyboardType, this.textInputAction, this.controller, this.hintText, this.onChanged, this.onEditingComplete, this.focusNode, this.enabled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType : keyboardType ?? TextInputType.text,
      textInputAction: textInputAction ?? TextInputAction.next,
      controller : controller,
      enabled: enabled,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      focusNode: focusNode,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 35,vertical: 20),
          filled: true,
          fillColor: Color(0xffF0F1F1),
          hintText: hintText,
          hintStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.6)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(100),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(100),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(100),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide(color: Colors.white)
          )
      ),
    );
  }
}
