import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_woc/app/core/enums/space.dart';
import 'package:whatsapp_clone_woc/app/core/get_it/get_it.dart';
import 'package:whatsapp_clone_woc/app/data/models/chat_model.dart';
import 'package:whatsapp_clone_woc/app/data/models/user_model.dart';
import 'package:whatsapp_clone_woc/app/presentation/message/cubit/message_cubit.dart';
import 'package:whatsapp_clone_woc/app/presentation/message/widgets/message_bubble.dart';
import 'package:whatsapp_clone_woc/app/presentation/message/widgets/submit_message.dart';

class MessageView extends StatelessWidget {
  final ChatModel chatModel;
  final UserModel userModel;
  const MessageView({
    super.key,
    required this.chatModel,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageCubit, MessageState>(
      bloc: getIt.get<MessageCubit>()..getMessages(chatModel),
      builder: (context, state) {
        var cubit = context.read<MessageCubit>();
        return Scaffold(
          appBar: AppBar(
            leadingWidth: 30,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            title: Row(
              children: [
                CircleAvatar(
                  maxRadius: 20,
                  backgroundImage: userModel.photoUrl == null
                      ? null
                      : NetworkImage(userModel.photoUrl!),
                ),
                SpaceWidth.xs.value,
                Text(
                  '${userModel.fullname}',
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.videocam),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.phone),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: cubit.getMessages(chatModel),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      return ListView.builder(
                        itemCount:
                            snapshot.data == null ? 0 : snapshot.data!.length,
                        itemBuilder: (context, index) {
                          if (snapshot.data != null) {
                            var messageModel = snapshot.data![index];
                            if (messageModel.isSeen == false &&
                                messageModel.sender != cubit.currentUser.id) {
                              cubit.seenMessage(
                                  chatModel.id!, messageModel, userModel.id!);
                            }

                            return MessageBubble(
                              isSentByMe:
                                  messageModel.sender == cubit.currentUser.id,
                              message: messageModel.message!,
                              isSeen: messageModel.isSeen ?? false,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                        reverse: true,
                      );
                    }),
              ),
              SubmitWidget(
                chatModel: chatModel,
                cubit: cubit,
                userModel: userModel,
              ),
            ],
          ),
        );
      },
    );
  }
}
