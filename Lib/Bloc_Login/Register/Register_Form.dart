import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Login/API/Requests/get_user_object.dart';
import '../Login/API/Response/user_object.dart';
import '../Model/api_model.dart';
import '../Bloc/authentication_bloc.dart';
import 'bloc/register_bloc.dart';
import 'Register_Button.dart';
import '../Login/bloc/login_bloc.dart';
import '../Repository/user_repository.dart';

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
          final userRepository = UserRepository();
          // UserDetails userDetails = UserDetails(username: _userNameController.text, email: _emailController.text, password: _passwordController.text);
          // UserSignup userSignup = UserSignup(user: userDetails);
          // UserLogin userLogin = await registerUser(userSignup);
          final user = await userRepository.authenticate(
              username: _userNameController.text,
              password: _passwordController.text,);
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn(user: user));
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
                    // autovalidate: true,
                    // validator: (_) {
                    //   return !state.isUsernameValid ? 'Invalid Username' : null;
                    // },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    // autovalidate: true,
                    // validator: (_) {
                    //   return !state.isEmailValid ? 'Invalid Email' : null;
                    // },
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
                    // autovalidate: true,
                    // validator: (_) {
                    //   return !state.isPasswordValid ? 'Invalid Password' : null;
                    // },
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