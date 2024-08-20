import 'dart:io';

import 'package:formz/formz.dart';

enum FileInputError {
  none,
}

extension FileInputErrorX on FileInputError {
  String get name => 'File';
  String get errorMessage {
    switch (this) {
      default:
        return '';
    }
  }
}

class FileInput extends FormzInput<File?, FileInputError> {
  const FileInput.pure() : super.pure(null);
  const FileInput.dirty({File? value}) : super.dirty(value);

  @override
  FileInputError? validator(File? value) {
    return null;
  }
}
