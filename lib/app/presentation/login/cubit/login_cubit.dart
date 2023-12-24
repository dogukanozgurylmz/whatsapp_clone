import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone_woc/app/data/models/user_model.dart';
import 'package:whatsapp_clone_woc/app/domain/repositories/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(
          LoginState(
            status: LoginStatus.init,
            imageFile: File(""),
            loginSuccess: false,
            signupSuccess: false,
          ),
        );

  final UserRepository _userRepository;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final PageController pageController = PageController();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      emit(state.copyWith(imageFile: imageTemp));
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> loginUser() async {
    var dataResult =
        await _userRepository.getByEmail(emailController.text.trim());
    if (dataResult.success) {
      emit(state.copyWith(loginSuccess: true));
    } else {
      emit(state.copyWith(loginSuccess: false));
    }
  }

  Future<void> signupUser() async {
    var getUserDataResult =
        await _userRepository.getByEmail(emailController.text.trim());
    if (!getUserDataResult.success) {
      var image = await _userRepository.uploadImage(state.imageFile);
      var userModel = UserModel(
        email: emailController.text.trim(),
        fullname: fullnameController.text.trim(),
        photoUrl: image.success ? image.data : null,
      );
      var dataResult = await _userRepository.create(userModel);
      if (dataResult.success) {
        emit(state.copyWith(signupSuccess: true));
      }
    } else {
      "Bu email zaten kayıtlı";
    }
  }
}
