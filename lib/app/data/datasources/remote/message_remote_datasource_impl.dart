import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone_woc/app/data/models/message_model.dart';
import 'package:whatsapp_clone_woc/app/domain/datasources/message_datasource.dart';

class MessageRemoteDatasourceImpl implements MessageDatasource {
  final CollectionReference<Map<String, dynamic>> _ref =
      FirebaseFirestore.instance.collection("users");

  @override
  Future<void> addMessage(
      String userId, String chatId, MessageModel model) async {
    await _ref
        .doc(userId)
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(model.id)
        .set(model.toJson());
  }

  @override
  Stream<List<MessageModel>> getMessages(String userId, String chatId) {
    return _ref
        .doc(userId)
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MessageModel.fromJson(doc.data()))
          .toList();
    });
  }

  @override
  Future<MessageModel> getLastMessage(String userId, String chatId) async {
    var querySnapshot = await _ref
        .doc(userId)
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .get();
    return MessageModel.fromJson(querySnapshot.docs.first.data());
  }

  @override
  Stream<MessageModel> streamLastMessage(String userId, String chatId) {
    var querySnapshot = _ref
        .doc(userId)
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((event) => MessageModel.fromJson(event.docs.first.data()));
    return querySnapshot;
  }

  @override
  Future<void> update(String userId, String chatId, MessageModel model) async {
    await _ref
        .doc(userId)
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(model.id)
        .set(model.toJson());
  }
}
