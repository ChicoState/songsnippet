import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc_Login/Bloc/authentication_bloc.dart';
import '../Resources/strings.dart';
import 'widgets/cards_stack_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text(SongSnippetStrings.title), actions: [
          ElevatedButton(
            child: const Text(
              SongSnippetStrings.logoutButton,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            },
          ),
        ]),
        body: const CardsStackWidget());
  }
}
