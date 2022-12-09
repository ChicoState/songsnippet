part of 'register_bloc.dart';

@immutable
class RegisterState {
  bool? isUsernameValid;
  bool? isEmailValid;
  bool? isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  RegisterState({
    required this.isUsernameValid,
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  factory RegisterState.empty() {
    return RegisterState(
      isUsernameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isUsernameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure() {
    return RegisterState(
      isUsernameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isUsernameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RegisterState update({
    bool? isUsernameValid,
    bool? isEmailValid,
    bool? isPasswordValid,
  }) {
    return copyWith(
      isUsernameValid: isUsernameValid,
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isSubmitEnabled: false,
    );
  }

  RegisterState copyWith({
    bool? isUsernameValid,
    bool? isEmailValid,
    bool? isPasswordValid,
    required bool isSubmitEnabled,
    required bool isSubmitting,
    required bool isSuccess,
    required bool isFailure,
  }) {
    return RegisterState(
      isUsernameValid: isUsernameValid,
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: isSubmitting,
      isSuccess: isSuccess,
      isFailure: isFailure,
    );
  }

  @override
  String toString() {
    return '''RegisterState {
      isUsernameValid: $isUsernameValid,
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}