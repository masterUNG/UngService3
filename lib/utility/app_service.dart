import 'dart:io';
import 'dart:math';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ungservice/utility/app_controller.dart';
import 'package:dio/dio.dart' as dio;

class AppService {
  //Depency GetX
  AppController appController = Get.put(AppController());

  Future<void> processTakePhoto({required ImageSource source}) async {
    var result = await ImagePicker().pickImage(
      source: source,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (result != null) {
      File file = File(result.path);
      appController.files.add(file);
    }
  }

  Future<void> processUploadImageAndInsertUser({
    required String name,
    required String user,
    required String password,
  }) async {
    String nameFile = 'ung${Random().nextInt(10000)}.jpg';

    Map<String, dynamic> map = {};
    map['file'] = await dio.MultipartFile.fromFile(
        appController.files.last.path,
        filename: nameFile);

    dio.FormData formData = dio.FormData.fromMap(map);

    String path =
        'http://androidthai.in.th/fluttertraining/master/saveAvatar.php';

    await dio.Dio().post(path, data: formData).then((value) async {
      String urlAvata =
          'http://androidthai.in.th/fluttertraining/master/avatar/$nameFile';
      print('urlAvata --> $urlAvata');

      String urlApi =
          'http://androidthai.in.th/fluttertraining/master/getUserWhereUser.php?isAdd=true&user=$user';

      await dio.Dio().get(urlApi).then((value) async {
        print('value from API ==> $value');

        if (value.toString() == 'null') {
          //User OK

          String urlAPIcreateAccount =
              'http://androidthai.in.th/fluttertraining/master/insertUser.php?isAdd=true&name=$name&user=$user&password=$password&avatar=$urlAvata';

          await dio.Dio().get(urlAPIcreateAccount).then((value) {
            Get.back();
            Get.snackbar('Welcome', 'Create New Account Success');
          });
        } else {
          Get.snackbar('User False', 'Please Change User');
        }
      });
    });
  }
}
