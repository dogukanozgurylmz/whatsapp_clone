import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone_woc/app/data/models/chat_model.dart';
import 'package:whatsapp_clone_woc/app/domain/datasources/chat_datasource.dart';

class ChatRemoteDatasourceImpl implements ChatDatasource {
  final CollectionReference<Map<String, dynamic>> _ref =
      FirebaseFirestore.instance.collection("users");

  @override
  Future<String> addChat(String userId, ChatModel model) async {
    await _ref
        .doc(userId)
        .collection('chats')
        .doc(model.id)
        .set(model.toJson());
    return model.id!;
  }

  @override
  Stream<List<ChatModel>> getChats(String userId) {
    return _ref.doc(userId).collection('chats').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ChatModel.fromJson(doc.data()))
          .toList();
    });
  }

  @override
  Future<void> update(String userId, ChatModel model) async {
    await _ref
        .doc(userId)
        .collection('chats')
        .doc(model.id)
        .update(model.toJson());
  }

  @override
  Future<ChatModel> getById(String userId, String id) async {
    var documentSnapshot =
        await _ref.doc(userId).collection('chats').doc(id).get();
    return ChatModel.fromJson(documentSnapshot.data()!);
  }
}
