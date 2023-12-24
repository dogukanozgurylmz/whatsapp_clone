import 'dart:io';
import 'package:whatsapp_clone_woc/app/data/models/user_model.dart';

abstract class UserDatasource {
  Future<String> create(UserModel model);
  Future delete(String id);
  Future deleteAll();
  Future update(UserModel model);
  Future<UserModel> getByEmail(String email);
  Future<List<UserModel>> getAll();
  Future<UserModel> getById(String id);
  UserModel currentUser();
  Future<String> uploadImage(File file);
}
