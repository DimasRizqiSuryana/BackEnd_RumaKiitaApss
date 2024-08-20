import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/base/base.dart';
import '../../../../utils/logger.dart';
import '../../../utils/extensions.dart';
import '../document_status/document_status_model.dart';
import '../election/election_model.dart';
import '../election_voter/election_voter_model.dart';
import '../media/media_model.dart';
import '../user/user_model.dart';
import '../utils.dart';

part 'election_registration_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class ElectionRegistrationListModel extends Equatable {
  final List<ElectionRegistrationModel> data;
  final MetadataModel? meta;

  const ElectionRegistrationListModel({
    required this.data,
    this.meta,
  });

  @override
  List<Object?> get props => [
        data,
        meta,
      ];

  factory ElectionRegistrationListModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$ElectionRegistrationListModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message:
            'Failed to Parse `Map<String, dynamic>` into `ElectionRegistrationListModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$ElectionRegistrationListModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message:
            'Failed to Parse `ElectionRegistrationListModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class ElectionRegistrationModel extends Equatable {
  final int id;
  final ElectionRegistrationAttributeModel attributes;

  const ElectionRegistrationModel({
    required this.id,
    required this.attributes,
  });

  @override
  List<Object?> get props => [
        id,
        attributes,
      ];

  factory ElectionRegistrationModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$ElectionRegistrationModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message:
            'Failed to Parse `Map<String, dynamic>` into `ElectionRegistrationModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$ElectionRegistrationModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message:
            'Failed to Parse `ElectionRegistrationModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class ElectionRegistrationAttributeModel extends Equatable {
  @NestedJsonKey(name: 'users_permissions_user/data')
  final UserModel? user;

  @NestedJsonKey(name: 'election/data')
  final ElectionModel? election;

  @NestedJsonKey(name: 'document_status/data')
  final DocumentStatusModel? documentStatus;

  @NestedJsonKey(name: 'attachment/data')
  final MediaModel? attachment;

  @JsonKey(name: 'election_voters')
  final ElectionVoterListModel? voters;

  final String? rejectDescription;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;

  @JsonKey(name: 'publishedAt')
  final String publishedAt;

  const ElectionRegistrationAttributeModel({
    this.user,
    this.election,
    this.documentStatus,
    this.attachment,
    this.voters,
    this.rejectDescription,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  @override
  List<Object?> get props => [
        user,
        election,
        documentStatus,
        attachment,
        voters,
        rejectDescription,
        createdAt,
        updatedAt,
        publishedAt,
      ];

  factory ElectionRegistrationAttributeModel.fromJson(
      Map<String, dynamic> json) {
    try {
      return _$ElectionRegistrationAttributeModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message:
            'Failed to Parse `Map<String, dynamic>` into `ElectionRegistrationAttributeModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$ElectionRegistrationAttributeModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message:
            'Failed to Parse `ElectionRegistrationAttributeModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}
