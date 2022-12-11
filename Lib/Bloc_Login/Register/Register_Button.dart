import 'package:flutter/material.dart';
import 'Resources/strings.dart';
class RegisterButton extends StatelessWidget {
  final VoidCallback? _onPressed;

  const RegisterButton({Key? key, VoidCallback? onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressed,
      child: Text(RegisterStrings.registerButtonText),
    );
  }
}