import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:song_snippet/Resources/dimen.dart';
import 'Bloc/register_bloc.dart';
import 'Register_Button.dart';
import 'Resources/strings.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late RegisterBloc _registerBloc;
  bool passwordVisible = true;

  bool get isPopulated =>
      _userNameController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) async {
        if (state.isSubmitting) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(RegisterStrings.pendingRegistrationString),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(RegisterStrings.snackbarRegistrationSuccess),
                  Icon(Icons.check),
                ],
              ),
              backgroundColor: Colors.lightGreen,
            ),
          );
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(RegisterStrings.snackbarRegistrationFailure),
                  Icon(Icons.error),
                ],
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(SongSnippetDimen.padding2x),
            child: Form(
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: _userNameController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: RegisterStrings.registerUsernamePlaceholder,
                    ),
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: RegisterStrings.registerEmailPlaceholder,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.lock),
                      labelText: RegisterStrings.registerPasswordPlaceholder,
                      suffixIcon: IconButton(
                          icon: passwordVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          color: Theme.of(context).primaryColorDark,
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          }),
                    ),
                    obscureText: passwordVisible,
                    autocorrect: false,
                  ),
                  const SizedBox(
                    height: SongSnippetDimen.padding3x,
                  ),
                  RegisterButton(
                    onPressed: isRegisterButtonEnabled(state)
                        ? _onFormSubmitted
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      Submitted(
        userName: _userNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
