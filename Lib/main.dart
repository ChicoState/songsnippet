import 'package:flutter/material.dart';
import 'package:song_snippet/Home/home_view_model.dart';
import 'Resources/theme.dart';
import 'Home/home.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:song_snippet/Repository/user_repository.dart';
import 'package:song_snippet/bloc/authentication_bloc.dart';
import 'package:song_snippet/Splash/splash.dart';
import '../Lib/Login/login_page.dart';
import 'package:song_snippet/Common/common.dart';

void main() {
  final userRepository = UserRepository();

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

  App({Key? key, required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
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