import 'package:get_it/get_it.dart';
import 'package:whatsapp_clone_woc/app/data/datasources/local/user_local_datasource_impl.dart';
import 'package:whatsapp_clone_woc/app/data/datasources/remote/chat_remote_datasource_impl.dart';
import 'package:whatsapp_clone_woc/app/data/datasources/remote/message_remote_datasource_impl.dart';
import 'package:whatsapp_clone_woc/app/data/datasources/remote/user_remote_datasource_impl.dart';
import 'package:whatsapp_clone_woc/app/data/repositories/chat_repository_impl.dart';
import 'package:whatsapp_clone_woc/app/data/repositories/message_repository_impl.dart';
import 'package:whatsapp_clone_woc/app/data/repositories/user_repository_impl.dart';
import 'package:whatsapp_clone_woc/app/domain/datasources/chat_datasource.dart';
import 'package:whatsapp_clone_woc/app/domain/datasources/message_datasource.dart';
import 'package:whatsapp_clone_woc/app/domain/repositories/chat_repository.dart';
import 'package:whatsapp_clone_woc/app/domain/repositories/message_repository.dart';
import 'package:whatsapp_clone_woc/app/domain/repositories/user_repository.dart';
import 'package:whatsapp_clone_woc/app/presentation/chats/cubit/chats_cubit.dart';
import 'package:whatsapp_clone_woc/app/presentation/home/cubit/home_cubit.dart';
import 'package:whatsapp_clone_woc/app/presentation/message/cubit/message_cubit.dart';

final getIt = GetIt.instance;

void setupGetIT() {
  setupRepositories();
  setupDatasource();
  setupBLoC();
}

void setupRepositories() {
  getIt
    ..registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(),
    )
    ..registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(),
    )
    ..registerLazySingleton<MessageRepository>(
      () => MessageRepositoryImpl(),
    );
}

void setupDatasource() {
  getIt
    ..registerLazySingleton<UserRemoteDatasourceImpl>(
      () => UserRemoteDatasourceImpl(),
    )
    ..registerLazySingleton<UserLocalDatasourceImpl>(
      () => UserLocalDatasourceImpl(),
    )
    ..registerLazySingleton<ChatDatasource>(
      () => ChatRemoteDatasourceImpl(),
    )
    ..registerLazySingleton<MessageDatasource>(
      () => MessageRemoteDatasourceImpl(),
    );
}

void setupBLoC() {
  getIt
    ..registerLazySingleton<ChatsCubit>(
      () => ChatsCubit(
        chatRepository: getIt(),
        userRepository: getIt(),
        messageRepository: getIt(),
      ),
    )
    ..registerLazySingleton<HomeCubit>(
      () => HomeCubit(
        userRepository: getIt(),
        chatRepository: getIt(),
      ),
    )
    ..registerLazySingleton<MessageCubit>(
      () => MessageCubit(
        messageRepository: getIt(),
        userRepository: getIt(),
        chatRepository: getIt(),
      ),
    );
}
