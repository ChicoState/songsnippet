import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'Repository/user_repository.dart';

import 'Bloc/authentication_bloc.dart';
import 'Login/Bloc/login_bloc.dart';
import 'Login/login_form.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  const LoginPage({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: LoginForm(),
      ),
    );
  }
}
