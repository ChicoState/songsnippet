part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends RegisterEvent {
  final String email;

  const EmailChanged({required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  const PasswordChanged({required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class Submitted extends RegisterEvent {
  final String userName;
  final String email;
  final String password;

  const Submitted({
    required this.userName,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [userName, email, password];

  @override
  String toString() {
    return 'Submitted { username: $userName, $email, password: $password}';
  }
}
