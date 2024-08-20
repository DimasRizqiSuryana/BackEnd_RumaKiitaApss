import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/base/base.dart';
import '../../../../utils/logger.dart';
import '../../../utils/extensions.dart';
import '../document_status/document_status_model.dart';
import '../media/media_model.dart';
import '../user/user_model.dart';
import '../utils.dart';

part 'aduan_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class AduanListModel extends Equatable {
  final List<AduanModel> data;
  final MetadataModel? meta;

  const AduanListModel({
    required this.data,
    this.meta,
  });

  @override
  List<Object?> get props => [
        data,
        meta,
      ];

  factory AduanListModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$AduanListModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message: 'Failed to Parse `Map<String, dynamic>` into `AduanListModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$AduanListModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message: 'Failed to Parse `AduanListModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class AduanModel extends Equatable {
  final int id;
  final AduanAttributeModel attributes;

  const AduanModel({
    required this.id,
    required this.attributes,
  });

  @override
  List<Object?> get props => [
        id,
        attributes,
      ];

  factory AduanModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$AduanModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message: 'Failed to Parse `Map<String, dynamic>` into `AduanModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$AduanModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message: 'Failed to Parse `AduanModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class AduanAttributeModel extends Equatable {
  @NestedJsonKey(name: 'users_permissions_user/data')
  final UserModel? user;

  @NestedJsonKey(name: 'document_status/data')
  final DocumentStatusModel? documentStatus;

  final String title;
  final String description;
  final String location;
  final String dateOfIncident;
  final String? rejectDescription;

  @NestedJsonKey(name: 'attachment/data')
  final MediaModel? attachment;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;

  @JsonKey(name: 'publishedAt')
  final String publishedAt;

  const AduanAttributeModel({
    this.user,
    this.documentStatus,
    required this.title,
    required this.description,
    required this.location,
    required this.dateOfIncident,
    this.rejectDescription,
    this.attachment,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  @override
  List<Object?> get props => [
        user,
        documentStatus,
        title,
        description,
        location,
        dateOfIncident,
        rejectDescription,
        attachment,
        createdAt,
        updatedAt,
        publishedAt,
      ];

  factory AduanAttributeModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$AduanAttributeModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message:
            'Failed to Parse `Map<String, dynamic>` into `AduanAttributeModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$AduanAttributeModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message:
            'Failed to Parse `AduanAttributeModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}
