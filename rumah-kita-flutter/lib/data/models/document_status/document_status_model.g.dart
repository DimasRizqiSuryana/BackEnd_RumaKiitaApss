// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentStatusListModel _$DocumentStatusListModelFromJson(
        Map<String, dynamic> json) =>
    DocumentStatusListModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => DocumentStatusModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetadataModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DocumentStatusListModelToJson(
        DocumentStatusListModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta?.toJson(),
    };

DocumentStatusModel _$DocumentStatusModelFromJson(Map<String, dynamic> json) =>
    DocumentStatusModel(
      id: (json['id'] as num).toInt(),
      attributes: DocumentStatusAttributeModel.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DocumentStatusModelToJson(
        DocumentStatusModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

DocumentStatusAttributeModel _$DocumentStatusAttributeModelFromJson(
        Map<String, dynamic> json) =>
    DocumentStatusAttributeModel(
      status: json['status'] as String,
      label: json['label'] as String,
      description: json['description'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      publishedAt: json['publishedAt'] as String,
    );

Map<String, dynamic> _$DocumentStatusAttributeModelToJson(
        DocumentStatusAttributeModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'label': instance.label,
      'description': instance.description,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'publishedAt': instance.publishedAt,
    };
