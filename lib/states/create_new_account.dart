import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ungservice/utility/app_controller.dart';
import 'package:ungservice/utility/app_dialog.dart';
import 'package:ungservice/utility/app_service.dart';
import 'package:ungservice/widgets/widget_button.dart';
import 'package:ungservice/widgets/widget_form.dart';
import 'package:ungservice/widgets/widget_icon_button.dart';
import 'package:ungservice/widgets/widget_image_assets.dart';
import 'package:ungservice/widgets/widget_image_file.dart';
import 'package:ungservice/widgets/widget_text.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({super.key});

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  AppController appController = Get.put(AppController());

  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (appController.files.isNotEmpty) {
      appController.files.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const WidgetText(data: 'Create New Account'),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          children: [
            displayImage(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        WidgetForm(
                          textEditingController: nameController,
                          validateFunc: (p0) {
                            if (p0?.isEmpty ?? true) {
                              return 'Please Fill Name';
                            } else {
                              return null;
                            }
                          },
                          labelWidget: const WidgetText(data: 'Display Name :'),
                        ),
                        WidgetForm(
                          textEditingController: userController,
                          validateFunc: (p0) {
                            if (p0?.isEmpty ?? true) {
                              return 'Please Fill User';
                            } else {
                              return null;
                            }
                          },
                          labelWidget: const WidgetText(data: 'User :'),
                        ),
                        WidgetForm(
                          textEditingController: passwordController,
                          validateFunc: (p0) {
                            if (p0?.isEmpty ?? true) {
                              return 'Please Fill Password';
                            } else {
                              return null;
                            }
                          },
                          labelWidget: const WidgetText(data: 'Password :'),
                        ),
                        Container(
                          width: 250,
                          margin: const EdgeInsets.only(top: 8),
                          child: WidgetButton(
                            text: 'Create New Account',
                            pressFunc: () {
                              if (appController.files.isEmpty) {
                                //No Image
                                Get.snackbar('No Photo', 'Please Take Photo');
                              } else {
                                //Have Image
                                if (formKey.currentState!.validate()) {
                                  AppService().processUploadImageAndInsertUser(
                                    name: nameController.text,
                                    user: userController.text,
                                    password: passwordController.text,
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row displayImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          height: 250,
          child: Stack(
            children: [
              Obx(() => appController.files.isEmpty
                  ? const WidgetImageAssets(
                      path: 'images/account.png',
                      size: 220,
                    )
                  : WidgetImageFile(
                      file: appController.files.last,
                      size: 220,
                      boxFit: BoxFit.cover,
                    )),
              Positioned(
                bottom: 0,
                right: 0,
                child: WidgetIconButton(
                  iconData: Icons.add_a_photo,
                  pressFunc: () {
                    AppDialog().normalDialog(
                        title: 'Please Take Photo',
                        firsttWidget: WidgetButton(
                          gfButtonType: GFButtonType.outline,
                          text: 'Camera',
                          pressFunc: () {
                            Get.back();
                            AppService()
                                .processTakePhoto(source: ImageSource.camera);
                          },
                        ),
                        secondWidget: WidgetButton(
                          gfButtonType: GFButtonType.outline,
                          text: 'Gallery',
                          pressFunc: () {
                            Get.back();
                            AppService()
                                .processTakePhoto(source: ImageSource.gallery);
                          },
                        ));
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
