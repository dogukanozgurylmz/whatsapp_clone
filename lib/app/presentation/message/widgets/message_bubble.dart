import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.isSentByMe,
    required this.message,
    required this.isSeen,
  });

  final bool isSentByMe;
  final bool isSeen;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSentByMe
              ? Theme.of(context).secondaryHeaderColor
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: TextStyle(
                color: isSentByMe ? Colors.white : Colors.black,
              ),
            ),
            Visibility(
              visible: isSentByMe,
              child: isSeen
                  ? Icon(
                      Icons.check_circle,
                      color: Theme.of(context).secondaryHeaderColor,
                      size: 16,
                    )
                  : const Icon(
                      Icons.check_circle_outline,
                      color: Colors.grey,
                      size: 16,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
