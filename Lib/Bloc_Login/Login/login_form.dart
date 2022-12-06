import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Login/bloc/login_bloc.dart';
import 'create_account_button.dart';
import '../Repository/user_repository.dart';

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
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'username', icon: Icon(Icons.person)),
                      controller: _usernameController,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'password', icon: Icon(Icons.security)),
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.width * 0.22,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: ElevatedButton(
                          onPressed: state is! LoginLoading
                              ? _onLoginButtonPressed
                              : null,
                          child: const Text('Login'),
                          ),
                        ),
                      ),
                    Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
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