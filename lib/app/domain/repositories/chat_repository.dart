import 'package:whatsapp_clone_woc/app/core/result/result.dart';
import 'package:whatsapp_clone_woc/app/data/models/chat_model.dart';

abstract class ChatRepository {
  Future<DataResult<String>> addChat(String userId, ChatModel model);
  Future<Result> update(String userId, ChatModel model);
  Future<DataResult<ChatModel>> getById(String userId, String id);
  Stream<List<ChatModel>> getChats(String userId);
}
