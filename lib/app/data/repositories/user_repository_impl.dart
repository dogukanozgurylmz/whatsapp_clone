import 'dart:io';

import 'package:whatsapp_clone_woc/app/core/result/result.dart';
import 'package:whatsapp_clone_woc/app/data/datasources/local/user_local_datasource_impl.dart';
import 'package:whatsapp_clone_woc/app/data/datasources/remote/user_remote_datasource_impl.dart';
import 'package:whatsapp_clone_woc/app/data/models/user_model.dart';
import 'package:whatsapp_clone_woc/app/domain/datasources/user_datasource.dart';
import 'package:whatsapp_clone_woc/app/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource _remoteDatasourceImpl = UserRemoteDatasourceImpl();

  final UserDatasource _localDatasourceImpl = UserLocalDatasourceImpl();
  @override
  Future<DataResult<String>> create(UserModel model) async {
    try {
      var id = await _remoteDatasourceImpl.create(model);
      await _localDatasourceImpl.create(model);
      return SuccessDataResult(data: id);
    } catch (e) {
      return ErrorDataResult(message: "User create $e");
    }
  }

  @override
  Future<DataResult<UserModel>> getByEmail(String email) async {
    try {
      await _localDatasourceImpl.deleteAll();
      var userModel = await _remoteDatasourceImpl.getByEmail(email);
      var currentUser = _localDatasourceImpl.currentUser();
      if (currentUser == UserModel()) {
        await _localDatasourceImpl.create(userModel);
      }
      return SuccessDataResult(data: userModel);
    } catch (e) {
      return ErrorDataResult(message: "User getByEmail $e");
    }
  }

  @override
  Future<Result> update(UserModel model) async {
    try {
      await _remoteDatasourceImpl.update(model);
      return SuccessResult();
    } catch (e) {
      return ErrorResult(message: "User update $e");
    }
  }

  @override
  Future<DataResult<UserModel>> getById(String id) async {
    try {
      var userModel = await _remoteDatasourceImpl.getById(id);
      return SuccessDataResult(data: userModel);
    } catch (e) {
      return ErrorDataResult(message: "User getById $e");
    }
  }

  @override
  DataResult<UserModel> currentUser() {
    try {
      var currentUser = _localDatasourceImpl.currentUser();
      return SuccessDataResult(data: currentUser);
    } catch (e) {
      return ErrorDataResult(message: "User currentUser $e");
    }
  }

  @override
  Future<Result> delete(String id) async {
    try {
      await _remoteDatasourceImpl.delete(id);
      return SuccessResult();
    } catch (e) {
      return ErrorResult(message: "User delete $e");
    }
  }

  @override
  Future<Result> deleteAll() async {
    try {
      await _localDatasourceImpl.deleteAll();
      return SuccessResult();
    } catch (e) {
      return ErrorResult(message: "User deleteAll $e");
    }
  }

  @override
  Future<DataResult<String>> uploadImage(File file) async {
    try {
      var imageUrl = await _remoteDatasourceImpl.uploadImage(file);
      return SuccessDataResult(data: imageUrl);
    } catch (e) {
      return ErrorDataResult(message: "User uploadImage $e");
    }
  }

  @override
  Future<DataResult<List<UserModel>>> getAll() async {
    try {
      var list = await _remoteDatasourceImpl.getAll();
      return SuccessDataResult(data: list);
    } catch (e) {
      return ErrorDataResult(message: "User getAll $e");
    }
  }
}
