import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone_woc/app/data/models/chat_model.dart';
import 'package:whatsapp_clone_woc/app/data/models/user_model.dart';
import 'package:whatsapp_clone_woc/app/domain/repositories/chat_repository.dart';
import 'package:whatsapp_clone_woc/app/domain/repositories/user_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required UserRepository userRepository,
    required ChatRepository chatRepository,
  })  : _userRepository = userRepository,
        _chatRepository = chatRepository,
        super(
          const HomeState(
            status: HomeStatus.init,
            users: [],
          ),
        ) {
    getAllUsers();
    currentUser = _userRepository.currentUser().data!;
  }

  final UserRepository _userRepository;
  final ChatRepository _chatRepository;

  String chatId = "";
  late final UserModel currentUser;
  ChatModel chatModel = ChatModel(
    id: "",
    name: "",
    photo: "",
    uid: "",
    isSeen: true,
    lastDate: DateTime.now(),
    lastMessage: "",
  );

  Future<void> getAllUsers() async {
    var dataResult = await _userRepository.getAll();
    if (dataResult.success) {
      emit(state.copyWith(users: dataResult.data));
    }
  }

  Future<void> createChat(String userId, UserModel user) async {
    var currentChatModel = ChatModel(
      id: user.id,
      name: user.fullname,
      photo: user.photoUrl,
      uid: user.id,
      isSeen: true,
      lastDate: DateTime.now(),
      lastMessage: "",
    );
    var userChatModel = ChatModel(
      id: currentUser.id!,
      name: currentUser.fullname,
      photo: currentUser.photoUrl,
      uid: currentUser.id,
      isSeen: true,
      lastDate: DateTime.now(),
      lastMessage: "",
    );
    await _chatRepository.addChat(user.id!, userChatModel);
    var dataResult =
        await _chatRepository.addChat(currentUser.id!, currentChatModel);
    if (dataResult.success) {
      chatId = dataResult.data!;
      await getChatById();
    }
  }

  Future<void> getChatById() async {
    var dataResult = await _chatRepository.getById(currentUser.id!, chatId);
    if (dataResult.success) {
      chatModel = dataResult.data!;
    }
  }
}
