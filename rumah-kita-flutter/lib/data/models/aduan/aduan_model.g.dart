// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aduan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AduanListModel _$AduanListModelFromJson(Map<String, dynamic> json) =>
    AduanListModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => AduanModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetadataModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AduanListModelToJson(AduanListModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta?.toJson(),
    };

AduanModel _$AduanModelFromJson(Map<String, dynamic> json) => AduanModel(
      id: (json['id'] as num).toInt(),
      attributes: AduanAttributeModel.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AduanModelToJson(AduanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

AduanAttributeModel _$AduanAttributeModelFromJson(Map<String, dynamic> json) =>
    AduanAttributeModel(
      user: nestedReader(json, 'users_permissions_user/data') == null
          ? null
          : UserModel.fromJson(nestedReader(json, 'users_permissions_user/data')
              as Map<String, dynamic>),
      documentStatus: nestedReader(json, 'document_status/data') == null
          ? null
          : DocumentStatusModel.fromJson(
              nestedReader(json, 'document_status/data')
                  as Map<String, dynamic>),
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      dateOfIncident: json['date_of_incident'] as String,
      rejectDescription: json['reject_description'] as String?,
      attachment: nestedReader(json, 'attachment/data') == null
          ? null
          : MediaModel.fromJson(
              nestedReader(json, 'attachment/data') as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      publishedAt: json['publishedAt'] as String,
    );

Map<String, dynamic> _$AduanAttributeModelToJson(
        AduanAttributeModel instance) =>
    <String, dynamic>{
      'users_permissions_user/data': instance.user?.toJson(),
      'document_status/data': instance.documentStatus?.toJson(),
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'date_of_incident': instance.dateOfIncident,
      'reject_description': instance.rejectDescription,
      'attachment/data': instance.attachment?.toJson(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'publishedAt': instance.publishedAt,
    };
