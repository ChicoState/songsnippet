import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/register_bloc.dart';
import 'Register_Button.dart';

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

  bool
  isRegisterButtonEnabled(RegisterState state) {
    print(state);
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
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Registration Failure'),
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
            padding: const EdgeInsets.all(20),
            child: Form(
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: _userNameController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Username',
                    ),
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.lock),
                      labelText: 'Password',
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
                    height: 25.0,
                  ),

                  RegisterButton(
                    onPressed: isRegisterButtonEnabled(state) ?
                    _onFormSubmitted : null,
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