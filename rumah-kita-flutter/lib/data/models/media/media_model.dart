import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/base/base.dart';
import '../../../../utils/logger.dart';
import '../../../presentation/widgets/img.dart';
import '../../../utils/constants.dart';

part 'media_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class MediaModel extends Equatable {
  final int id;
  final MediaAttributeModel attributes;

  const MediaModel({
    required this.id,
    required this.attributes,
  });

  @override
  List<Object?> get props => [
        id,
        attributes,
      ];

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$MediaModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message: 'Failed to Parse `Map<String, dynamic>` into `MediaModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$MediaModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message: 'Failed to Parse `MediaModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }

  FileMetadata toFileMetadata() {
    try {
      String source = '';
      if (attributes.provider == 'local') {
        source = baseUrl + (attributes.url);
      } else {
        source = attributes.url;
      }

      return FileMetadata.remote(source: source);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message: 'Failed to Parse `MediaAttributeModel` into `RoleEntity`',
        stacktrace: stacktrace,
      );
    }
  }
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class MediaAttributeModel extends Equatable {
  final String name;
  final String hash;
  final String ext;
  final String mime;
  final double size;
  final String url;
  final String provider;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;

  const MediaAttributeModel({
    required this.name,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    required this.provider,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        name,
        hash,
        ext,
        mime,
        size,
        url,
        provider,
        createdAt,
        updatedAt,
      ];

  factory MediaAttributeModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$MediaAttributeModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message:
            'Failed to Parse `Map<String, dynamic>` into `MediaAttributeModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$MediaAttributeModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message:
            'Failed to Parse `MediaAttributeModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}
