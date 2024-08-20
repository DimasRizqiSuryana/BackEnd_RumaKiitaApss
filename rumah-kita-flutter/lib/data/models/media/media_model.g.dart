// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaModel _$MediaModelFromJson(Map<String, dynamic> json) => MediaModel(
      id: (json['id'] as num).toInt(),
      attributes: MediaAttributeModel.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MediaModelToJson(MediaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

MediaAttributeModel _$MediaAttributeModelFromJson(Map<String, dynamic> json) =>
    MediaAttributeModel(
      name: json['name'] as String,
      hash: json['hash'] as String,
      ext: json['ext'] as String,
      mime: json['mime'] as String,
      size: (json['size'] as num).toDouble(),
      url: json['url'] as String,
      provider: json['provider'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$MediaAttributeModelToJson(
        MediaAttributeModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'hash': instance.hash,
      'ext': instance.ext,
      'mime': instance.mime,
      'size': instance.size,
      'url': instance.url,
      'provider': instance.provider,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
