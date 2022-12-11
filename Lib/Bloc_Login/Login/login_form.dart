import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Resources/dimen.dart';
import '../Login/Bloc/login_bloc.dart';
import 'create_account_button.dart';
import '../Repository/user_repository.dart';
import 'Resources/strings.dart';
import 'Resources/dimen.dart';

class LoginForm extends StatefulWidget {

  @override
  State<LoginForm> createState() => _LoginFormState();
  final _userRepository = UserRepository();

}
class _LoginFormState extends State<LoginForm> {
  UserRepository get _userRepository => widget._userRepository;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFaliure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${state.error}'), backgroundColor: Colors.red,));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(SongSnippetDimen.padding6x),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: LoginStrings.loginUsernamePlaceholder, icon: Icon(Icons.person)),
                      controller: _usernameController,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: LoginStrings.loginPasswordPlaceholder, icon: Icon(Icons.security)),
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * LoginDimen.loginButtonWidthMultiplier,
                      height: MediaQuery.of(context).size.width * LoginDimen.loginButtonHeightMultiplier,
                      child: Padding(
                        padding: const EdgeInsets.only(top: SongSnippetDimen.padding4x),
                        child: ElevatedButton(
                          onPressed: state is! LoginLoading
                              ? _onLoginButtonPressed
                              : null,
                          child: const Text(LoginStrings.loginButtonText),
                          ),
                        ),
                      ),
                    Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: SongSnippetDimen.padding3x),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              CreateAccountButton(
                                  userRepository: _userRepository),
                            ],
                          ),
                        )
                    ),

                    Container(
                      child: state is LoginLoading
                          ? const CircularProgressIndicator()
                          : null,
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}