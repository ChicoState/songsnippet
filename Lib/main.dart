import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Repository/user_repository.dart';
import 'bloc/authentication_bloc.dart';
import 'Login/login_page.dart';
import 'Common/common.dart';
import 'widgets/cards_stack_widget.dart';

enum Swipe { left, right, none }

void main() {
  final userRepository = UserRepository();
  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted());
    },
    child: App(
      userRepository: userRepository,
      key: null,
    ),
  ));
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  const App({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUnintialized) {
            return Scaffold(
              body: Center(
                child: Text('Splash Screen'),
              ),
            );
          }
          if (state is AuthenticationAuthenticated) {
            return const CardsStackWidget();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(userRepository: userRepository, key: null);
          }
          return LoadingIndicator();
        },
      ),
    );
  }
}
