// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'election_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElectionListModel _$ElectionListModelFromJson(Map<String, dynamic> json) =>
    ElectionListModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => ElectionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetadataModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ElectionListModelToJson(ElectionListModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta?.toJson(),
    };

ElectionModel _$ElectionModelFromJson(Map<String, dynamic> json) =>
    ElectionModel(
      id: (json['id'] as num).toInt(),
      attributes: ElectionAttributeModel.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ElectionModelToJson(ElectionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

ElectionAttributeModel _$ElectionAttributeModelFromJson(
        Map<String, dynamic> json) =>
    ElectionAttributeModel(
      electionParty: json['election_parties'] == null
          ? null
          : ElectionPartyListModel.fromJson(
              json['election_parties'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      publishedAt: json['publishedAt'] as String,
    );

Map<String, dynamic> _$ElectionAttributeModelToJson(
        ElectionAttributeModel instance) =>
    <String, dynamic>{
      'election_parties': instance.electionParty?.toJson(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'publishedAt': instance.publishedAt,
    };
