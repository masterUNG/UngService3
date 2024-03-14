import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ungservice/states/create_new_account.dart';
import 'package:ungservice/utility/app_constant.dart';
import 'package:ungservice/utility/app_controller.dart';
import 'package:ungservice/widgets/widget_button.dart';
import 'package:ungservice/widgets/widget_form.dart';
import 'package:ungservice/widgets/widget_icon_button.dart';
import 'package:ungservice/widgets/widget_image_assets.dart';
import 'package:ungservice/widgets/widget_text.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  //นี่คือ Dependency เอาไว้ Call ตัวแปรที่อยู่ใน AppController
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          decoration: AppConstant().imageBox(),
          child: Stack(
            children: [
              ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 64,
                            ),
                            displayLogo(),
                            userForm(),
                            passwordForm(),
                            loginButton()
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WidgetButton(
                        gfButtonType: GFButtonType.transparent,
                        text: 'Create New Account',
                        pressFunc: () {
                          Get.to(const CreateNewAccount());
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container loginButton() {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(top: 8),
      child: WidgetButton(
        text: 'Login',
        pressFunc: () {},
      ),
    );
  }

  Obx passwordForm() {
    return Obx(() => WidgetForm(
          suffixWidget: WidgetIconButton(
            iconData: appController.redEye.value
                ? Icons.remove_red_eye
                : Icons.remove_red_eye_outlined,
            pressFunc: () {
              appController.redEye.value = !appController.redEye.value;
            },
          ),
          obsecre: appController.redEye.value,
          hint: 'Password :',
        ));
  }

  WidgetForm userForm() {
    return WidgetForm(
      suffixWidget: Icon(Icons.account_circle_outlined),
      hint: 'User :',
    );
  }

  Row displayLogo() {
    return Row(
      children: [
        const WidgetImageAssets(
          size: 60,
        ),
        WidgetText(
          data: AppConstant.appName,
          textStyle: AppConstant().h2Style(size: 25),
        )
      ],
    );
  }
}
