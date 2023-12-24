import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone_woc/app/data/models/chat_model.dart';
import 'package:whatsapp_clone_woc/app/data/models/message_model.dart';
import 'package:whatsapp_clone_woc/app/data/models/user_model.dart';
import 'package:whatsapp_clone_woc/app/domain/repositories/chat_repository.dart';
import 'package:whatsapp_clone_woc/app/domain/repositories/message_repository.dart';
import 'package:whatsapp_clone_woc/app/domain/repositories/user_repository.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit({
    required ChatRepository chatRepository,
    required UserRepository userRepository,
    required MessageRepository messageRepository,
  })  : _chatRepository = chatRepository,
        _userRepository = userRepository,
        _messageRepository = messageRepository,
        super(
          const ChatsState(
            status: ChatsStatus.init,
            chats: Stream.empty(),
            users: [],
            messages: [],
            lastMessage: Stream.empty(),
          ),
        ) {
    currentUser = _userRepository.currentUser().data!;
  }

  final ChatRepository _chatRepository;
  final UserRepository _userRepository;
  final MessageRepository _messageRepository;

  late UserModel currentUser;

  Stream<List<ChatModel>> getChats() {
    var chats = _chatRepository.getChats(currentUser.id!);
    return chats;
  }

  Future<MessageModel?> lastMessage(String chatId) async {
    var dataResult =
        await _messageRepository.getLastMessage(currentUser.id!, chatId);
    return dataResult.data;
  }
}
