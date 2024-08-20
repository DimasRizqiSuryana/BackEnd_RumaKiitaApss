// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utils.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetadataModel _$MetadataModelFromJson(Map<String, dynamic> json) =>
    MetadataModel(
      pagination: json['pagination'] == null
          ? null
          : PaginationApiModel.fromJson(
              json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MetadataModelToJson(MetadataModel instance) =>
    <String, dynamic>{
      'pagination': instance.pagination?.toJson(),
    };

PaginationApiModel _$PaginationApiModelFromJson(Map<String, dynamic> json) =>
    PaginationApiModel(
      page: (json['page'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      pageCount: (json['pageCount'] as num).toInt(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$PaginationApiModelToJson(PaginationApiModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'pageCount': instance.pageCount,
      'total': instance.total,
    };
