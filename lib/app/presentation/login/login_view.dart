import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_woc/app/presentation/login/cubit/login_cubit.dart';
import 'package:whatsapp_clone_woc/app/presentation/login/widgets/login_body.dart';
import 'package:whatsapp_clone_woc/app/presentation/login/widgets/signup_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp'),
      ),
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          var cubit = context.read<LoginCubit>();
          return PageView(
            controller: cubit.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              Padding(
                padding: EdgeInsets.all(32.0),
                child: LoginBody(),
              ),
              Padding(
                padding: EdgeInsets.all(32.0),
                child: SignupBody(),
              ),
            ],
          );
        },
      ),
    );
  }
}
