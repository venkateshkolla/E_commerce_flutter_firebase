import 'package:a_ecommerce/constans.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hinttext;
  final Function(String) onchanged;
  final Function(String) onsubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPasswordField;

  CustomInput(
      {this.hinttext,
      this.onchanged,
      this.onsubmitted,
      this.focusNode,
      this.textInputAction,
      this.isPasswordField});
  @override
  Widget build(BuildContext context) {
    bool _ispasswordField = isPasswordField ?? false;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      decoration: BoxDecoration(
          color: Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(12.0)),
      child: TextField(
        focusNode: focusNode,
        onChanged: onchanged,
        onSubmitted: onsubmitted,
        textInputAction: textInputAction,
        obscureText: _ispasswordField,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hinttext ?? "Hint Text...",
            contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 24)),
        style: Constants.regularDarktext,
      ),
    );
  }
}
