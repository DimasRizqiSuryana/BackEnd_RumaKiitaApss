import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/base/base.dart';
import '../../../utils/logger.dart';

part 'utils.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class MetadataModel extends Equatable {
  final PaginationApiModel? pagination;

  const MetadataModel({
    required this.pagination,
  });

  @override
  List<Object?> get props => [
        pagination,
      ];

  factory MetadataModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$MetadataModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message: 'Failed to Parse `Map<String, dynamic>` into `MetadataModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$MetadataModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message: 'Failed to Parse `MetadataModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class PaginationApiModel extends Equatable {
  final int page;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  @JsonKey(name: 'pageCount')
  final int pageCount;

  final int total;

  const PaginationApiModel({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  @override
  List<Object?> get props => [
        page,
        pageSize,
        pageCount,
        total,
      ];

  factory PaginationApiModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$PaginationApiModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message:
            'Failed to Parse `Map<String, dynamic>` into `PaginationApiModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$PaginationApiModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message:
            'Failed to Parse `PaginationApiModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}

class Collection<T> extends Equatable {
  final List<T> data;
  final PaginationApiModel pagination;

  const Collection({
    required this.data,
    required this.pagination,
  });

  @override
  List<Object?> get props => [data, pagination];
}
