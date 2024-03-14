// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({
    Key? key,
    required this.text,
    required this.pressFunc,
    this.gfButtonType,
  }) : super(key: key);

  final String text;
  final Function() pressFunc;
  final GFButtonType? gfButtonType;

  @override
  Widget build(BuildContext context) {
    return GFButton(type: gfButtonType ?? GFButtonType.solid,
      onPressed: pressFunc,
      text: text,
    );
  }
}
