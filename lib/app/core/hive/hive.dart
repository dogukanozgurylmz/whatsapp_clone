import 'package:hive_flutter/hive_flutter.dart';
import 'package:whatsapp_clone_woc/app/data/models/user_model.dart';

late Box<UserModel> userBox;

Future<void> hiveInit() async {
  await Hive.initFlutter();
  hiveRegisterAdapter();
  await hiveBox();
}

Future<void> hiveBox() async {
  userBox = await Hive.openBox<UserModel>('user');
}

void hiveRegisterAdapter() {
  Hive.registerAdapter<UserModel>(UserModelAdapter());
}
