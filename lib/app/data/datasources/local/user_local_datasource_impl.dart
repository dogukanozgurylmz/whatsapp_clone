import 'dart:io';

import 'package:whatsapp_clone_woc/app/core/hive/hive.dart';
import 'package:whatsapp_clone_woc/app/data/models/user_model.dart';
import 'package:whatsapp_clone_woc/app/domain/datasources/user_datasource.dart';

class UserLocalDatasourceImpl implements UserDatasource {
  @override
  Future<String> create(UserModel model) async {
    await userBox.put(model.id, model);
    return "";
  }

  @override
  Future<UserModel> getByEmail(String email) {
    // TODO: implement getByEmail
    throw UnimplementedError();
  }

  @override
  Future<UserModel> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future update(UserModel model) async {
    await userBox.put(model.id, model);
  }

  @override
  UserModel currentUser() {
    if (userBox.isEmpty) {
      return UserModel();
    }
    return userBox.values.first;
  }

  @override
  Future delete(String id) async {
    await userBox.delete(id);
  }

  @override
  Future deleteAll() async {
    await userBox.clear();
  }

  @override
  Future<String> uploadImage(File file) {
    // TODO: implement uploadImage
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }
}
