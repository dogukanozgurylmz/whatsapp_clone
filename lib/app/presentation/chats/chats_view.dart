import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_woc/app/core/get_it/get_it.dart';
import 'package:whatsapp_clone_woc/app/data/models/user_model.dart';
import 'package:whatsapp_clone_woc/app/presentation/chats/cubit/chats_cubit.dart';
import 'package:whatsapp_clone_woc/app/presentation/chats/widgets/chat_widget.dart';
import 'package:whatsapp_clone_woc/app/presentation/message/message_view.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsCubit, ChatsState>(
      bloc: getIt.get<ChatsCubit>()..getChats(),
      builder: (context, state) {
        var cubit = context.read<ChatsCubit>();
        return StreamBuilder(
            stream: cubit.getChats(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  if (snapshot.data != null) {
                    var chatModel = snapshot.data![index];
                    return GestureDetector(
                      onTap: () {
                        var userModel = UserModel(
                          id: chatModel.uid,
                          fullname: chatModel.name,
                          photoUrl: chatModel.photo,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessageView(
                              chatModel: chatModel,
                              userModel: userModel,
                            ),
                          ),
                        ).whenComplete(
                            () async => await cubit.lastMessage(chatModel.id!));
                      },
                      child: ChatWidget(
                        chatModel: chatModel,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              );
            });
      },
    );
  }
}
