import 'package:whatsapp_clone_woc/app/core/result/result.dart';
import 'package:whatsapp_clone_woc/app/data/models/message_model.dart';

abstract class MessageRepository {
  Future<Result> addMessage(String userId, String chatId, MessageModel model);
  Future<Result> updateMessage(
      String userId, String chatId, MessageModel model);
  Future<DataResult<MessageModel>> getLastMessage(String userId, String chatId);
  Stream<List<MessageModel>> getMessages(String userId, String chatId);
  Stream<MessageModel> streamLastMessage(String userId, String chatId);
}
