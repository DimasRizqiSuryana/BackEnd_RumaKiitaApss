import 'package:formz/formz.dart';

enum ConfirmPasswordInputError {
  empty,
  invalidLength,
  mismatch,
}

extension ConfirmPasswordInputErrorX on ConfirmPasswordInputError {
  String get name => 'Konfirmasi Password';
  String get errorMessage {
    switch (this) {
      case ConfirmPasswordInputError.empty:
        return 'Input tidak boleh kosong';
      case ConfirmPasswordInputError.invalidLength:
        return 'Kata sandi minimal 8 karakter';
      case ConfirmPasswordInputError.mismatch:
        return 'Password tidak sama';
      default:
        return '';
    }
  }
}

class ConfirmPasswordInput
    extends FormzInput<String, ConfirmPasswordInputError> {
  final String password;

  const ConfirmPasswordInput.pure({
    this.password = '',
  }) : super.pure('');

  const ConfirmPasswordInput.dirty({
    String value = '',
    required this.password,
  }) : super.dirty(value);

  @override
  ConfirmPasswordInputError? validator(String? value) {
    if (value!.isEmpty) {
      return ConfirmPasswordInputError.empty;
    } else if (value.length < 8) {
      return ConfirmPasswordInputError.invalidLength;
    } else if (password != value) {
      return ConfirmPasswordInputError.mismatch;
    }

    return null;
  }
}
