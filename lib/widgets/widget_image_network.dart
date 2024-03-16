// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetImageNetwork extends StatelessWidget {
  const WidgetImageNetwork({
    super.key,
    required this.urlImage,
    this.boxFit,
    this.size,
  });

  final String urlImage;
  final BoxFit? boxFit;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      urlImage,
      width: size,
      height: size,
      fit: boxFit,
    );
  }
}
