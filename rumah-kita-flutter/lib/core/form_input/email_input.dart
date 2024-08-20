import 'package:formz/formz.dart';

enum EmailInputError {
  empty,
  invalidFormat,
}

extension EmailInputErrorX on EmailInputError {
  String get name => 'Email';
  String get errorMessage {
    switch (this) {
      case EmailInputError.empty:
        return 'Input tidak boleh kosong';
      case EmailInputError.invalidFormat:
        return 'Format email harus [local-part]@[domain]';
      default:
        return '';
    }
  }
}

class EmailInput extends FormzInput<String, EmailInputError> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty({String value = ''}) : super.dirty(value);

  static final _regex = RegExp(
    r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailInputError? validator(String? value) {
    if (value!.isEmpty) {
      return EmailInputError.empty;
    } else if (!_regex.hasMatch(value)) {
      return EmailInputError.invalidFormat;
    }

    return null;
  }
}
