part of 'message_cubit.dart';

enum MessageStatus {
  init,
  success,
  loading,
  error,
}

class MessageState extends Equatable {
  final MessageStatus status;
  final Stream<List<MessageModel>> messages;
  final UserModel userModel;
  final bool isListen;

  const MessageState({
    required this.status,
    required this.messages,
    required this.userModel,
    required this.isListen,
  });

  MessageState copyWith({
    MessageStatus? status,
    Stream<List<MessageModel>>? messages,
    UserModel? userModel,
    bool? isListen,
  }) {
    return MessageState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      userModel: userModel ?? this.userModel,
      isListen: isListen ?? this.isListen,
    );
  }

  @override
  List<Object> get props => [
        status,
        messages,
        userModel,
        isListen,
      ];
}
