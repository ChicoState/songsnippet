import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc_Login/Repository/user_repository.dart';
import 'Bloc_Login/Bloc/authentication_bloc.dart';
import 'Bloc_Login/login_page.dart';
import 'Bloc_Login/Common/common.dart';
import 'Home/home.dart';
import 'Resources/strings.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

void main() {
  final userRepository = UserRepository();
  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted());
    },
    child: App(
      userRepository: userRepository,
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
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUnintialized) {
            return const Scaffold(
              body: Center(
                child: Text(SongSnippetStrings.splashScreenText),
              ),
            );
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
      navigatorObservers: [ routeObserver ],
    );
  }
}
