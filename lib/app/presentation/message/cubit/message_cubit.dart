import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clone_woc/app/data/models/chat_model.dart';
import 'package:whatsapp_clone_woc/app/data/models/message_model.dart';
import 'package:whatsapp_clone_woc/app/data/models/user_model.dart';
import 'package:whatsapp_clone_woc/app/domain/repositories/chat_repository.dart';
import 'package:whatsapp_clone_woc/app/domain/repositories/message_repository.dart';
import 'package:whatsapp_clone_woc/app/domain/repositories/user_repository.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit({
    required MessageRepository messageRepository,
    required UserRepository userRepository,
    required ChatRepository chatRepository,
  })  : _messageRepository = messageRepository,
        _userRepository = userRepository,
        _chatRepository = chatRepository,
        super(
          MessageState(
            status: MessageStatus.init,
            messages: const Stream.empty(),
            userModel: UserModel(),
            isListen: false,
          ),
        ) {
    currentUser = _userRepository.currentUser().data!;
  }

  final MessageRepository _messageRepository;
  final UserRepository _userRepository;
  final ChatRepository _chatRepository;

  final TextEditingController messageController = TextEditingController();

  late UserModel currentUser;

  Stream<List<MessageModel>> getMessages(ChatModel chatModel) {
    var messages =
        _messageRepository.getMessages(currentUser.id!, chatModel.id!);
    return messages;
  }

  Future<void> getUserById(String userId) async {
    var dataResult = await _userRepository.getById(userId);
    if (dataResult.success) {
      emit(state.copyWith(userModel: dataResult.data));
    }
  }

  Future<void> sendMessage(ChatModel chatModel, String userId) async {
    Uuid uuid = const Uuid();
    var currentMessageModel = MessageModel(
      id: uuid.v4(),
      sender: currentUser.id,
      message: messageController.text.trim(),
      isSeen: false,
      createdAt: DateTime.now(),
    );
    await _messageRepository.addMessage(
      userId,
      currentUser.id!,
      currentMessageModel,
    );
    await _messageRepository.addMessage(
      currentUser.id!,
      userId,
      currentMessageModel,
    );
    await updateYourChat(chatModel);
    messageController.clear();
  }

  Future<void> seenMessage(
      String chatId, MessageModel model, String userId) async {
    model.isSeen = true;
    await _messageRepository.updateMessage(userId, currentUser.id!, model);
    await _messageRepository.updateMessage(currentUser.id!, userId, model);
  }

  Future<void> updateYourChat(ChatModel chatModel) async {
    chatModel.lastMessage = messageController.text.trim();
    chatModel.lastDate = DateTime.now();
    await _chatRepository.update(currentUser.id!, chatModel);
    chatModel.id = currentUser.id!;
    chatModel.uid = currentUser.id!;
    await _chatRepository.update(chatModel.id!, chatModel);
  }
}
