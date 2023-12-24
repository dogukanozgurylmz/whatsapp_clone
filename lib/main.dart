import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_woc/app/core/get_it/get_it.dart';
import 'package:whatsapp_clone_woc/app/core/hive/hive.dart';
import 'package:whatsapp_clone_woc/app/presentation/chats/cubit/chats_cubit.dart';
import 'package:whatsapp_clone_woc/app/presentation/home/cubit/home_cubit.dart';
import 'package:whatsapp_clone_woc/app/presentation/login/cubit/login_cubit.dart';
import 'package:whatsapp_clone_woc/app/presentation/login/login_view.dart';
import 'package:whatsapp_clone_woc/app/presentation/message/cubit/message_cubit.dart';
import 'package:whatsapp_clone_woc/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  hiveInit();
  setupGetIT();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(
            userRepository: getIt(),
            chatRepository: getIt(),
          ),
        ),
        BlocProvider(
          create: (context) => ChatsCubit(
            chatRepository: getIt(),
            userRepository: getIt(),
            messageRepository: getIt(),
          ),
        ),
        BlocProvider(
          create: (context) => MessageCubit(
            messageRepository: getIt(),
            userRepository: getIt(),
            chatRepository: getIt(),
          ),
        ),
        BlocProvider(
          create: (context) => LoginCubit(
            userRepository: getIt(),
          ),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          // useMaterial3: true,
          primaryColor: const Color(0xFF075E54),
          secondaryHeaderColor: const Color(0xFF25D366),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF075E54),
            elevation: 1,
          ),
          tabBarTheme: const TabBarTheme(
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xFF128C7E),
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white, width: 2.0),
              ),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const LoginView(),
      ),
    );
  }
}
