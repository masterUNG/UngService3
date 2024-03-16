import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ungservice/models/user_model.dart';
import 'package:ungservice/widgets/widget_image_network.dart';
import 'package:ungservice/widgets/widget_text.dart';

class BodyProfile extends StatefulWidget {
  const BodyProfile({super.key});

  @override
  State<BodyProfile> createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
  UserModel? userModel;

  @override
  void initState() {
    super.initState();

    userModel = UserModel.fromMap(GetStorage().read('user'));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        WidgetText(data: 'Name : ${userModel!.name}'),
        const SizedBox(height: 26,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetImageNetwork(
              urlImage: userModel!.avatar,
              size: 250,
              boxFit: BoxFit.cover,
            ),
          ],
        )
      ],
    );
  }
}
