import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_woc/app/core/enums/space.dart';
import 'package:whatsapp_clone_woc/app/presentation/home/home_view.dart';
import 'package:whatsapp_clone_woc/app/presentation/login/cubit/login_cubit.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        var cubit = context.read<LoginCubit>();
        return BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.loginSuccess) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeView(),
                  ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Unsuccessful Login'),
                ),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SpaceHeight.xl.value,
              TextField(
                controller: cubit.emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.mail),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  await cubit.loginUser();
                },
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () async {
                  await cubit.pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInCubic,
                  );
                },
                child: const Text("Sign up"),
              ),
            ],
          ),
        );
      },
    );
  }
}
