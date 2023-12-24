import 'package:whatsapp_clone_woc/app/core/result/result.dart';
import 'package:whatsapp_clone_woc/app/data/datasources/remote/chat_remote_datasource_impl.dart';
import 'package:whatsapp_clone_woc/app/data/models/chat_model.dart';
import 'package:whatsapp_clone_woc/app/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDatasourceImpl _remoteDatasourceImpl =
      ChatRemoteDatasourceImpl();

  @override
  Future<DataResult<String>> addChat(String userId, ChatModel model) async {
    try {
      var id = await _remoteDatasourceImpl.addChat(userId, model);
      return SuccessDataResult(data: id);
    } catch (e) {
      return ErrorDataResult(message: "Chat addChat $e");
    }
  }

  @override
  Stream<List<ChatModel>> getChats(String userId) {
    try {
      var chats = _remoteDatasourceImpl.getChats(userId);
      return chats;
    } catch (e) {
      return const Stream.empty();
    }
  }

  @override
  Future<Result> update(String userId, ChatModel model) async {
    try {
      await _remoteDatasourceImpl.update(userId, model);

      return SuccessResult();
    } catch (e) {
      return ErrorResult(message: "Chat update $e");
    }
  }

  @override
  Future<DataResult<ChatModel>> getById(String userId, String id) async {
    try {
      var chatModel = await _remoteDatasourceImpl.getById(userId, id);
      return SuccessDataResult(data: chatModel);
    } catch (e) {
      return ErrorDataResult(message: "Chat getById $e");
    }
  }
}
