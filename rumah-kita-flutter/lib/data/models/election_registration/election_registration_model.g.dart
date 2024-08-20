// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'election_registration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElectionRegistrationListModel _$ElectionRegistrationListModelFromJson(
        Map<String, dynamic> json) =>
    ElectionRegistrationListModel(
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              ElectionRegistrationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetadataModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ElectionRegistrationListModelToJson(
        ElectionRegistrationListModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta?.toJson(),
    };

ElectionRegistrationModel _$ElectionRegistrationModelFromJson(
        Map<String, dynamic> json) =>
    ElectionRegistrationModel(
      id: (json['id'] as num).toInt(),
      attributes: ElectionRegistrationAttributeModel.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ElectionRegistrationModelToJson(
        ElectionRegistrationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

ElectionRegistrationAttributeModel _$ElectionRegistrationAttributeModelFromJson(
        Map<String, dynamic> json) =>
    ElectionRegistrationAttributeModel(
      user: nestedReader(json, 'users_permissions_user/data') == null
          ? null
          : UserModel.fromJson(nestedReader(json, 'users_permissions_user/data')
              as Map<String, dynamic>),
      election: nestedReader(json, 'election/data') == null
          ? null
          : ElectionModel.fromJson(
              nestedReader(json, 'election/data') as Map<String, dynamic>),
      documentStatus: nestedReader(json, 'document_status/data') == null
          ? null
          : DocumentStatusModel.fromJson(
              nestedReader(json, 'document_status/data')
                  as Map<String, dynamic>),
      attachment: nestedReader(json, 'attachment/data') == null
          ? null
          : MediaModel.fromJson(
              nestedReader(json, 'attachment/data') as Map<String, dynamic>),
      voters: json['election_voters'] == null
          ? null
          : ElectionVoterListModel.fromJson(
              json['election_voters'] as Map<String, dynamic>),
      rejectDescription: json['reject_description'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      publishedAt: json['publishedAt'] as String,
    );

Map<String, dynamic> _$ElectionRegistrationAttributeModelToJson(
        ElectionRegistrationAttributeModel instance) =>
    <String, dynamic>{
      'users_permissions_user/data': instance.user?.toJson(),
      'election/data': instance.election?.toJson(),
      'document_status/data': instance.documentStatus?.toJson(),
      'attachment/data': instance.attachment?.toJson(),
      'election_voters': instance.voters?.toJson(),
      'reject_description': instance.rejectDescription,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'publishedAt': instance.publishedAt,
    };
