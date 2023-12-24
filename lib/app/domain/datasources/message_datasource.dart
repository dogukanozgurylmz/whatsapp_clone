import 'package:whatsapp_clone_woc/app/data/models/message_model.dart';

abstract class MessageDatasource {
  Future<void> addMessage(String userId, String chatId, MessageModel model);
  Future<void> update(String userId, String chatId, MessageModel model);
  Future<MessageModel> getLastMessage(String userId, String chatId);
  Stream<List<MessageModel>> getMessages(String userId, String chatId);
  Stream<MessageModel> streamLastMessage(String userId, String chatId);
}
