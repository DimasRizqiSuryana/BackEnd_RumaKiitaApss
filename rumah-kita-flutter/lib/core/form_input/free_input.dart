import 'package:formz/formz.dart';

enum FreeInputError {
  none,
}

extension FreeInputErrorX on FreeInputError {
  String get name => 'Input';
  String get errorMessage {
    switch (this) {
      default:
        return '';
    }
  }
}

class FreeInput extends FormzInput<String, FreeInputError> {
  const FreeInput.pure() : super.pure('');
  const FreeInput.dirty({String value = ''}) : super.dirty(value);

  @override
  FreeInputError? validator(String? value) {
    return null;
  }
}
