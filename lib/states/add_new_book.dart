import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ungservice/utility/app_service.dart';
import 'package:ungservice/widgets/widget_icon_button.dart';
import 'package:ungservice/widgets/widget_image_assets.dart';
import 'package:ungservice/widgets/widget_text.dart';

class AddNewBook extends StatelessWidget {
  const AddNewBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const WidgetText(data: 'Add New Book'),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                width: 250,
                height: 250,
                child: Stack(
                  children: [
                    const WidgetImageAssets(
                      size: 250,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: WidgetIconButton(
                        iconData: Icons.cloud_upload,
                        pressFunc: () {
                          AppService().processUploadPdf();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
