part of 'home_cubit.dart';

enum HomeStatus {
  init,
  success,
  error,
}

class HomeState extends Equatable {
  final HomeStatus status;
  final List<UserModel> users;

  const HomeState({
    required this.status,
    required this.users,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<UserModel>? users,
  }) {
    return HomeState(
      status: status ?? this.status,
      users: users ?? this.users,
    );
  }

  @override
  List<Object> get props => [
        status,
        users,
      ];
}
