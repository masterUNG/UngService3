// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    this.hint,
    this.suffixWidget,
    this.labelWidget,
    this.obsecre,
    this.validateFunc,
    this.textEditingController,
  }) : super(key: key);

  final String? hint;
  final Widget? suffixWidget;
  final Widget? labelWidget;
  final bool? obsecre;
  final String? Function(String?)? validateFunc;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: TextFormField(controller: textEditingController,
        validator: validateFunc,
        obscureText: obsecre ?? false,
        decoration: InputDecoration(
          label: labelWidget,
          suffixIcon: suffixWidget,
          hintText: hint,
          filled: true,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
