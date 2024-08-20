import 'package:formz/formz.dart';

enum IdentifierInputError {
  invalid,
}

extension IdentifierInputErrorX on IdentifierInputError {
  String get name => 'Identifier';
  String get errorMessage {
    switch (this) {
      case IdentifierInputError.invalid:
        return 'Identifier invalid';
      default:
        return '';
    }
  }
}

class IdentifierInput extends FormzInput<int, IdentifierInputError> {
  const IdentifierInput.pure() : super.pure(0);
  const IdentifierInput.dirty({int value = 0}) : super.dirty(value);

  @override
  IdentifierInputError? validator(int value) {
    if (value <= 0) {
      return IdentifierInputError.invalid;
    }

    return null;
  }
}
