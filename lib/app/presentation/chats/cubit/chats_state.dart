part of 'chats_cubit.dart';

enum ChatsStatus {
  init,
  success,
  error,
  loading,
}

class ChatsState extends Equatable {
  final ChatsStatus status;
  final Stream<List<ChatModel>> chats;
  final List<UserModel> users;
  final List<MessageModel> messages;
  final Stream<MessageModel> lastMessage;

  const ChatsState({
    required this.status,
    required this.chats,
    required this.users,
    required this.messages,
    required this.lastMessage,
  });

  ChatsState copyWith({
    ChatsStatus? status,
    Stream<List<ChatModel>>? chats,
    List<UserModel>? users,
    List<MessageModel>? messages,
    Stream<MessageModel>? lastMessage,
  }) {
    return ChatsState(
      status: status ?? this.status,
      chats: chats ?? this.chats,
      users: users ?? this.users,
      messages: messages ?? this.messages,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        chats,
        users,
        messages,
        lastMessage,
      ];
}
