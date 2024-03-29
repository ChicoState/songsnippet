import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Repository/user_repository.dart';
import '../Register/Bloc/register_bloc.dart';
import '../Register/Register_Form.dart';
import 'Resources/strings.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const RegisterScreen({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(RegisterStrings.registerScreenTitle),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(userRepository: _userRepository),
          child: const RegisterForm(),
        ),
      ),
    );
  }
}
