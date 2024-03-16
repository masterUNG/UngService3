import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:ungservice/utility/app_controller.dart';
import 'package:ungservice/utility/app_dialog.dart';
import 'package:ungservice/widgets/body_list.dart';
import 'package:ungservice/widgets/body_profile.dart';
import 'package:ungservice/widgets/widget_button.dart';
import 'package:ungservice/widgets/widget_image_assets.dart';
import 'package:ungservice/widgets/widget_text.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  AppController appController = Get.put(AppController());

  var titles = <String>[
    'List',
    'Profile',
  ];
  var widgets = <Widget>[
    const WidgetImageAssets(
      size: 36,
    ),
    const WidgetImageAssets(
      path: 'images/account.png',
      size: 36,
    ),
  ];
  var bodys = <Widget>[
    const BodyList(),
    const BodyProfile(),
  ];

  var items = <BottomNavigationBarItem>[];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < titles.length; i++) {
      BottomNavigationBarItem item = BottomNavigationBarItem(
        icon: widgets[i],
        label: titles[i],
      );
      items.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: WidgetText(data: titles[appController.indexBody.value]),
            actions: [
              appController.indexBody.value == 1
                  ? Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: WidgetButton(
                        gfButtonType: GFButtonType.outline,
                        text: 'Sign Out',
                        pressFunc: () {
                          AppDialog().normalDialog(
                            title: 'Confirm SignOut',
                            firsttWidget: WidgetButton(
                              text: 'Confirm',
                              pressFunc: () {
                                GetStorage().erase().then(
                                    (value) => Get.offAllNamed('/authen'));
                              },
                            ),
                            secondWidget: WidgetButton(
                              gfButtonType: GFButtonType.outline,
                              text: 'Cancel',
                              pressFunc: () {
                                Get.back();
                              },
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox()
            ],
          ),
          body: bodys[appController.indexBody.value],
          bottomNavigationBar: BottomNavigationBar(
            items: items,
            onTap: (value) {
              appController.indexBody.value = value;
            },
          ),
        ));
  }
}
