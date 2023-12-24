import 'dart:io';

import 'package:whatsapp_clone_woc/app/core/result/result.dart';
import 'package:whatsapp_clone_woc/app/data/models/user_model.dart';

abstract class UserRepository {
  Future<DataResult<String>> create(UserModel model);
  Future<Result> update(UserModel model);
  Future<Result> delete(String id);
  Future<Result> deleteAll();
  Future<DataResult<UserModel>> getByEmail(String email);
  Future<DataResult<List<UserModel>>> getAll();
  Future<DataResult<UserModel>> getById(String id);
  DataResult<UserModel> currentUser();
  Future<DataResult<String>> uploadImage(File file);
}
