part of 'login_cubit.dart';

enum LoginStatus {
  init,
  loading,
  success,
  error,
}

class LoginState extends Equatable {
  final LoginStatus status;
  final File imageFile;
  final bool loginSuccess;
  final bool signupSuccess;

  const LoginState({
    required this.status,
    required this.imageFile,
    required this.loginSuccess,
    required this.signupSuccess,
  });

  LoginState copyWith({
    LoginStatus? status,
    File? imageFile,
    bool? loginSuccess,
    bool? signupSuccess,
  }) {
    return LoginState(
      status: status ?? this.status,
      imageFile: imageFile ?? this.imageFile,
      loginSuccess: loginSuccess ?? this.loginSuccess,
      signupSuccess: signupSuccess ?? this.signupSuccess,
    );
  }

  @override
  List<Object> get props => [
        status,
        imageFile,
        loginSuccess,
        signupSuccess,
      ];
}
