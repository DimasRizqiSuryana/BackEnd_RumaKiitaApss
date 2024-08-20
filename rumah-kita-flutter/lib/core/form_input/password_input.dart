import 'package:formz/formz.dart';

enum PasswordInputError {
  empty,
  invalidLength,
}

extension PasswordInputErrorX on PasswordInputError {
  String get name => 'Password';
  String get errorMessage {
    switch (this) {
      case PasswordInputError.empty:
        return 'Input tidak boleh kosong';
      case PasswordInputError.invalidLength:
        return 'Password minimal 8 karakter';
      default:
        return '';
    }
  }
}

class PasswordInput extends FormzInput<String, PasswordInputError> {
  const PasswordInput.pure() : super.pure('');
  const PasswordInput.dirty({String value = ''}) : super.dirty(value);

  @override
  PasswordInputError? validator(String? value) {
    if (value!.isEmpty) {
      return PasswordInputError.empty;
    } else if (value.length < 8) {
      return PasswordInputError.invalidLength;
    }

    return null;
  }
}
