import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_woc/app/core/enums/space.dart';
import 'package:whatsapp_clone_woc/app/presentation/home/home_view.dart';
import 'package:whatsapp_clone_woc/app/presentation/login/cubit/login_cubit.dart';

class SignupBody extends StatelessWidget {
  const SignupBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        var cubit = context.read<LoginCubit>();
        return BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.signupSuccess) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeView(),
                  ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Unsuccessful signup'),
                ),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign up",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SpaceHeight.xl.value,
              GestureDetector(
                onTap: () async {
                  await cubit.pickImage();
                },
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Theme.of(context).primaryColor,
                  backgroundImage: state.imageFile.path == ""
                      ? null
                      : FileImage(state.imageFile),
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: cubit.emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.mail),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: cubit.fullnameController,
                decoration: const InputDecoration(
                  labelText: 'Fullname',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: cubit.signupUser,
                child: const Text('Sign up'),
              ),
              TextButton(
                onPressed: () async {
                  await cubit.pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInCubic,
                  );
                },
                child: const Text("Login"),
              ),
            ],
          ),
        );
      },
    );
  }
}
