import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_woc/app/presentation/chats/chats_view.dart';
import 'package:whatsapp_clone_woc/app/presentation/home/cubit/home_cubit.dart';
import 'package:whatsapp_clone_woc/app/presentation/message/message_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: const Color(0xff0c6157),
          title: const Text("WhatsApp"),
          bottom: const TabBar(
            dividerColor: Colors.white,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 4.0,
                color: Colors.white,
              ),
            ),
            tabs: <Widget>[
              Tab(
                text: "ARAMALAR",
              ),
              Tab(
                text: "SOHBETLER",
              ),
              Tab(
                text: "KİŞİLER",
              ),
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            var cubit = context.read<HomeCubit>();
            return FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: _scaffoldKey.currentContext!,
                  showDragHandle: true,
                  builder: (sheetContext) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        var user = state.users[index];
                        if (cubit.currentUser == user) {
                          return const SizedBox.shrink();
                        }
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            backgroundImage: user.photoUrl == null
                                ? null
                                : NetworkImage(user.photoUrl!),
                          ),
                          title: Text(user.fullname.toString()),
                          onTap: () async {
                            if (context.mounted) {
                              await cubit
                                  .createChat(user.id!, user)
                                  .whenComplete(
                                () async {
                                  Navigator.pop(sheetContext);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MessageView(
                                        chatModel: cubit.chatModel,
                                        userModel: user,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                );
              },
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.add,
              ),
            );
          },
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: Text("It's cloudy here"),
            ),
            ChatsView(),
            Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
      ),
    );
  }
}
