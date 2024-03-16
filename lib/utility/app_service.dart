import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ungservice/models/user_model.dart';
import 'package:ungservice/utility/app_controller.dart';
import 'package:dio/dio.dart' as dio;
import 'package:ungservice/utility/app_dialog.dart';
import 'package:ungservice/widgets/widget_text.dart';

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

  Future<void> processCheckLogin({
    required String user,
    required String password,
  }) async {
    String urlApi =
        'http://androidthai.in.th/fluttertraining/master/getUserWhereUser.php?isAdd=true&user=$user';

    await dio.Dio().get(urlApi).then((value) {
      if (value.toString() == 'null') {
        AppDialog().normalDialog(
            title: 'User False',
            contentWidget: WidgetText(data: 'No $user in my Database'));
      } else {
        for (var element in json.decode(value.data)) {
          UserModel model = UserModel.fromMap(element);

          if (password == model.password) {
            GetStorage().write('user', model.toMap());
            Get.offAllNamed('/mainHome');
          } else {
            AppDialog().normalDialog(title: 'Password False');
          }
        }
      }
    });
  }

  Future<void> processUploadPdf() async {
    var result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);

      String nameFile = 'pdf${Random().nextInt(100)}.pdf';

      Map<String, dynamic> map = {};
      map['file'] =
          await dio.MultipartFile.fromFile(file.path, filename: nameFile);
      dio.FormData formData = dio.FormData.fromMap(map);

      String urlSavePdf =
          'http://androidthai.in.th/fluttertraining/master/savePdf.php';
      await dio.Dio().post(urlSavePdf, data: formData).then((value) {
        print('Upload $nameFile success');
      });
    }
  }
}
