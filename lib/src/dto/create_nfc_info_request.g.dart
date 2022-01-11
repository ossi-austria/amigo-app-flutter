// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_nfc_info_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateNfcInfoRequest _$CreateNfcInfoRequestFromJson(
        Map<String, dynamic> json) =>
    CreateNfcInfoRequest(
      json['name'] as String,
      json['nfcRef'] as String,
      json['ownerId'] as String,
      json['creatorId'] as String,
    );

Map<String, dynamic> _$CreateNfcInfoRequestToJson(
        CreateNfcInfoRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'nfcRef': instance.nfcRef,
      'ownerId': instance.ownerId,
      'creatorId': instance.creatorId,
    };
