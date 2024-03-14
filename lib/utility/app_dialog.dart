import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ungservice/widgets/widget_button.dart';
import 'package:ungservice/widgets/widget_text.dart';

class AppDialog {
  void normalDialog({
    required String title,
    Widget? iconWidget,
    Widget? contentWidget,
    Widget? firsttWidget,
    Widget? secondWidget,
  }) {
    Get.dialog(AlertDialog(
      icon: iconWidget,
      title: WidgetText(data: title),
      content: contentWidget,
      actions: [
        firsttWidget ?? const SizedBox(),
        secondWidget ?? WidgetButton(text: 'OK', pressFunc: () => Get.back(),),
      ],
    ));
  }
}
