import 'package:whatsapp_clone_woc/app/core/result/result.dart';
import 'package:whatsapp_clone_woc/app/data/datasources/remote/message_remote_datasource_impl.dart';
import 'package:whatsapp_clone_woc/app/data/models/message_model.dart';
import 'package:whatsapp_clone_woc/app/domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDatasourceImpl _remoteDatasourceImpl =
      MessageRemoteDatasourceImpl();

  @override
  Future<Result> addMessage(
      String userId, String chatId, MessageModel model) async {
    try {
      await _remoteDatasourceImpl.addMessage(userId, chatId, model);
      return SuccessResult();
    } catch (e) {
      return ErrorResult(message: "Chat addChat $e");
    }
  }

  @override
  Stream<List<MessageModel>> getMessages(String userId, String chatId) {
    try {
      var messages = _remoteDatasourceImpl.getMessages(userId, chatId);
      return messages;
    } catch (e) {
      return const Stream.empty();
    }
  }

  @override
  Future<DataResult<MessageModel>> getLastMessage(
      String userId, String chatId) async {
    try {
      var messageModel =
          await _remoteDatasourceImpl.getLastMessage(userId, chatId);
      return SuccessDataResult(data: messageModel);
    } catch (e) {
      return ErrorDataResult(message: "Chat addChat $e");
    }
  }

  @override
  Future<Result> updateMessage(
      String userId, String chatId, MessageModel model) async {
    try {
      await _remoteDatasourceImpl.update(userId, chatId, model);
      return SuccessResult();
    } catch (e) {
      return ErrorResult(message: "Chat updateMessage $e");
    }
  }

  @override
  Stream<MessageModel> streamLastMessage(String userId, String chatId) {
    try {
      return _remoteDatasourceImpl.streamLastMessage(userId, chatId);
    } catch (e) {
      return const Stream.empty();
    }
  }
}
