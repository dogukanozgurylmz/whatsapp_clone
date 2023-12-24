import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clone_woc/app/data/models/user_model.dart';
import 'package:whatsapp_clone_woc/app/domain/datasources/user_datasource.dart';

class UserRemoteDatasourceImpl implements UserDatasource {
  final CollectionReference<Map<String, dynamic>> _ref =
      FirebaseFirestore.instance.collection("users");
  final Reference _storage = FirebaseStorage.instance.ref();
  @override
  Future<String> create(UserModel model) async {
    var id = _ref.doc().id;
    model.id = id;
    await _ref.doc(id).set(model.toJson());
    return id;
  }

  @override
  Future<UserModel> getByEmail(String email) async {
    var querySnapshot = await _ref.where('email', isEqualTo: email).get();
    var list =
        querySnapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();
    return list.first;
  }

  @override
  Future update(UserModel model) async {
    await _ref.doc(model.id).set(model.toJson());
  }

  @override
  Future<UserModel> getById(String id) async {
    var querySnapshot = await _ref.where('id', isEqualTo: id).get();
    var list =
        querySnapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();
    return list.first;
  }

  @override
  UserModel currentUser() {
    throw UnimplementedError();
  }

  @override
  Future delete(String id) async {
    await _ref.doc(id).delete();
  }

  @override
  Future deleteAll() {
    throw UnimplementedError();
  }

  @override
  Future<String> uploadImage(File file) async {
    String refId = const Uuid().v4();
    UploadTask uploadManager =
        _storage.child("user/photo_$refId.jpg").putFile(file);
    TaskSnapshot snapshot = await uploadManager;
    var photoUrl = await snapshot.ref.getDownloadURL();
    return photoUrl;
  }

  @override
  Future<List<UserModel>> getAll() async {
    var querySnapshot = await _ref.get();
    return querySnapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();
  }
}
