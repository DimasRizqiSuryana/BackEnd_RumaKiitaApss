import 'package:equatable/equatable.dart';

/// ValidationObject
class ValidationObject extends Equatable {
  final String identifier;
  final String name;
  final String message;

  const ValidationObject({
    this.identifier = 'identifier',
    this.name = 'Input Validasi',
    this.message = 'Validasi Gagal',
  });

  @override
  List<Object?> get props => [identifier, name, message];
}
