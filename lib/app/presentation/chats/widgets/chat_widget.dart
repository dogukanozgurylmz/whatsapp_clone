import 'package:flutter/material.dart';
import 'package:whatsapp_clone_woc/app/core/enums/space.dart';
import 'package:whatsapp_clone_woc/app/data/models/chat_model.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required this.chatModel,
  });
  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                maxRadius: 28,
                backgroundImage: chatModel.photo == null
                    ? null
                    : NetworkImage(chatModel.photo!),
              ),
              const Spacer(flex: 1),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${chatModel.name}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: !chatModel.isSeen!
                          ? Theme.of(context).secondaryHeaderColor
                          : Colors.grey,
                    ),
                  ),
                  SpaceHeight.xs.value,
                  Text(
                    chatModel.lastMessage.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: !chatModel.isSeen!
                          ? Theme.of(context).secondaryHeaderColor
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 7),
              Column(
                children: [
                  Text(
                    '${chatModel.lastDate!.hour}:${chatModel.lastDate!.minute}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: chatModel.isSeen!
                          ? Colors.grey
                          : Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(
          indent: 80,
          endIndent: 12,
          height: 2,
          thickness: 1,
        ),
      ],
    );
  }
}
