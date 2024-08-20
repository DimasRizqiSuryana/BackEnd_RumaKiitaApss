// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kerja_bakti_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KerjaBaktiListModel _$KerjaBaktiListModelFromJson(Map<String, dynamic> json) =>
    KerjaBaktiListModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => KerjaBaktiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetadataModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KerjaBaktiListModelToJson(
        KerjaBaktiListModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta?.toJson(),
    };

KerjaBaktiModel _$KerjaBaktiModelFromJson(Map<String, dynamic> json) =>
    KerjaBaktiModel(
      id: (json['id'] as num).toInt(),
      attributes: KerjaBaktiAttributeModel.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KerjaBaktiModelToJson(KerjaBaktiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

KerjaBaktiAttributeModel _$KerjaBaktiAttributeModelFromJson(
        Map<String, dynamic> json) =>
    KerjaBaktiAttributeModel(
      description: json['description'] as String,
      photos: (nestedReader(json, 'photos/data') as List<dynamic>?)
          ?.map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      publishedAt: json['publishedAt'] as String,
    );

Map<String, dynamic> _$KerjaBaktiAttributeModelToJson(
        KerjaBaktiAttributeModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'photos/data': instance.photos?.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'publishedAt': instance.publishedAt,
    };
