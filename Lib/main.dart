import 'dart:io';

import 'package:flutter/material.dart';
import 'Home/home_view_model.dart';
import 'Resources/theme.dart';
import 'Home/home.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Repository/user_repository.dart';
import 'bloc/authentication_bloc.dart';
import 'Splash/splash.dart';
import 'Login/login_page.dart';
import 'Common/common.dart';

void main() {
  final userRepository = UserRepository();
  stdout.writeln("00000000000000000000000000000000000000000000000000000");
  runApp(
      BlocProvider<AuthenticationBloc>(
        create: (context) {
          return AuthenticationBloc(
              userRepository: userRepository
          )..add(AppStarted());
        },
        child: App(userRepository: userRepository, key: null,),
      )
  );
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  const App({Key? key, required this.userRepository})
      : super(key: key);

  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUnintialized) {
            return SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            return const Home();
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