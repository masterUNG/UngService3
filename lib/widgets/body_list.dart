import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ungservice/states/add_new_book.dart';
import 'package:ungservice/widgets/widget_button.dart';
import 'package:ungservice/widgets/widget_text.dart';

class BodyList extends StatefulWidget {
  const BodyList({super.key});

  @override
  State<BodyList> createState() => _BodyListState();
}

class _BodyListState extends State<BodyList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Stack(
        children: [
          WidgetText(data: 'This is Body List'),
          Positioned(
            bottom: 16,
            right: 16,
            child: WidgetButton(
              text: 'Add Book',
              pressFunc: () {
                Get.to(const AddNewBook());
              },
            ),
          )
        ],
      ),
    );
  }
}
