part of 'edit_profile_picture_cubit.dart';

/// EditProfilePictureState
class EditProfilePictureState extends Equatable with FormzMixin {
  final FileInput photo;
  final FormzSubmissionStatus status;
  final ValidationObject? validation;
  final ErrorObject? error;

  const EditProfilePictureState({
    this.photo = const FileInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.validation,
    this.error,
  });

  @override
  List<Object?> get props => [
        photo,
        status,
        validation,
        error,
      ];

  @override
  List<FormzInput> get inputs => [
        photo,
      ];

  EditProfilePictureState copyWith({
    FileInput? photo,
    FormzSubmissionStatus? status,
    ValidationObject? validation,
    ErrorObject? error,
  }) {
    return EditProfilePictureState(
      photo: photo ?? this.photo,
      status: status ?? this.status,
      validation: validation,
      error: error,
    );
  }
}
