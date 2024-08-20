import 'package:formz/formz.dart';

enum DefaultInputError {
  empty,
}

extension DefaultInputErrorX on DefaultInputError {
  String get name => 'Input';
  String get errorMessage {
    switch (this) {
      case DefaultInputError.empty:
        return 'Input tidak boleh kosong';
      default:
        return '';
    }
  }
}

class DefaultInput extends FormzInput<String, DefaultInputError> {
  const DefaultInput.pure() : super.pure('');
  const DefaultInput.dirty({String value = ''}) : super.dirty(value);

  @override
  DefaultInputError? validator(String? value) {
    if (value!.isEmpty) {
      return DefaultInputError.empty;
    }

    return null;
  }
}
