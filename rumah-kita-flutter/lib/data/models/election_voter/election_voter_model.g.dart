// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'election_voter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElectionVoterListModel _$ElectionVoterListModelFromJson(
        Map<String, dynamic> json) =>
    ElectionVoterListModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => ElectionVoterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetadataModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ElectionVoterListModelToJson(
        ElectionVoterListModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta?.toJson(),
    };

ElectionVoterModel _$ElectionVoterModelFromJson(Map<String, dynamic> json) =>
    ElectionVoterModel(
      id: (json['id'] as num).toInt(),
      attributes: ElectionVoterAttributeModel.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ElectionVoterModelToJson(ElectionVoterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

ElectionVoterAttributeModel _$ElectionVoterAttributeModelFromJson(
        Map<String, dynamic> json) =>
    ElectionVoterAttributeModel(
      name: json['name'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      publishedAt: json['publishedAt'] as String,
    );

Map<String, dynamic> _$ElectionVoterAttributeModelToJson(
        ElectionVoterAttributeModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'publishedAt': instance.publishedAt,
    };
