import 'package:whatsapp_clone_woc/app/data/models/chat_model.dart';

abstract class ChatDatasource {
  Future<String> addChat(String userId, ChatModel model);
  Future<void> update(String userId, ChatModel model);
  Future<ChatModel> getById(String userId, String id);
  Stream<List<ChatModel>> getChats(String userId);
}
