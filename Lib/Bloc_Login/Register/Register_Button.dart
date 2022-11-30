import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback _onPressed;

  RegisterButton({required Key key, required VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressed,
      child: Text('Register'),
    );
  }
}