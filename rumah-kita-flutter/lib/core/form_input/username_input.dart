import 'package:formz/formz.dart';

enum UsernameInputError {
  empty,
  invalidFormat,
  invalidLength,
}

extension UsernameInputErrorX on UsernameInputError {
  String get name => 'Username';
  String get errorMessage {
    switch (this) {
      case UsernameInputError.empty:
        return 'Input tidak boleh kosong';
      case UsernameInputError.invalidFormat:
        return 'Username tidak boleh menggunakan spasi, hanya karakter dan underscore';
      default:
        return 'Username minimal 4 karakter dan maksimal 30 karakter';
    }
  }
}

class UsernameInput extends FormzInput<String, UsernameInputError> {
  const UsernameInput.pure() : super.pure('');
  const UsernameInput.dirty({String value = ''}) : super.dirty(value);

  static final _regex = RegExp(r'^[a-zA-Z0-9_]*$');

  @override
  UsernameInputError? validator(String? value) {
    if (value!.isEmpty) {
      return UsernameInputError.empty;
    } else if (!_regex.hasMatch(value)) {
      return UsernameInputError.invalidFormat;
    } else if (value.length < 4 || value.length > 30) {
      return UsernameInputError.invalidLength;
    }

    return null;
  }
}
