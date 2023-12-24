import 'package:flutter/material.dart';
import 'package:whatsapp_clone_woc/app/data/models/chat_model.dart';
import 'package:whatsapp_clone_woc/app/data/models/user_model.dart';
import 'package:whatsapp_clone_woc/app/presentation/message/cubit/message_cubit.dart';

class SubmitWidget extends StatelessWidget {
  const SubmitWidget({
    super.key,
    required this.chatModel,
    required this.cubit,
    required this.userModel,
  });

  final ChatModel chatModel;
  final MessageCubit cubit;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: cubit.messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                prefixIcon: const Icon(
                  Icons.emoji_emotions,
                  color: Colors.grey,
                ),
                suffixIcon: const Icon(
                  Icons.photo_camera,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.black12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () async {
              await cubit.sendMessage(
                chatModel,
                userModel.id!,
              );
            },
          ),
        ],
      ),
    );
  }
}
