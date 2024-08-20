import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/base/base.dart';
import '../../../../utils/logger.dart';
import '../../../utils/extensions.dart';
import '../media/media_model.dart';
import '../utils.dart';

part 'kerja_bakti_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class KerjaBaktiListModel extends Equatable {
  final List<KerjaBaktiModel> data;
  final MetadataModel? meta;

  const KerjaBaktiListModel({
    required this.data,
    this.meta,
  });

  @override
  List<Object?> get props => [
        data,
        meta,
      ];

  factory KerjaBaktiListModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$KerjaBaktiListModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message:
            'Failed to Parse `Map<String, dynamic>` into `KerjaBaktiListModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$KerjaBaktiListModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message:
            'Failed to Parse `KerjaBaktiListModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class KerjaBaktiModel extends Equatable {
  final int id;
  final KerjaBaktiAttributeModel attributes;

  const KerjaBaktiModel({
    required this.id,
    required this.attributes,
  });

  @override
  List<Object?> get props => [
        id,
        attributes,
      ];

  factory KerjaBaktiModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$KerjaBaktiModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message:
            'Failed to Parse `Map<String, dynamic>` into `KerjaBaktiModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$KerjaBaktiModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message:
            'Failed to Parse `KerjaBaktiModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class KerjaBaktiAttributeModel extends Equatable {
  final String description;

  @NestedJsonKey(name: 'photos/data')
  final List<MediaModel>? photos;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;

  @JsonKey(name: 'publishedAt')
  final String publishedAt;

  const KerjaBaktiAttributeModel({
    required this.description,
    this.photos,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  @override
  List<Object?> get props => [
        description,
        photos,
        createdAt,
        updatedAt,
        publishedAt,
      ];

  factory KerjaBaktiAttributeModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$KerjaBaktiAttributeModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message:
            'Failed to Parse `Map<String, dynamic>` into `KerjaBaktiAttributeModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$KerjaBaktiAttributeModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message:
            'Failed to Parse `KerjaBaktiAttributeModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}
