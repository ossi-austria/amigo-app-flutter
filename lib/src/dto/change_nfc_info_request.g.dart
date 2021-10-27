// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_nfc_info_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeNfcInfoRequest _$ChangeNfcInfoRequestFromJson(
        Map<String, dynamic> json) =>
    ChangeNfcInfoRequest(
      json['name'] as String?,
      json['linkedAlbumId'] as String?,
      json['linkedPersonId'] as String?,
    );

Map<String, dynamic> _$ChangeNfcInfoRequestToJson(
        ChangeNfcInfoRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'linkedAlbumId': instance.linkedAlbumId,
      'linkedPersonId': instance.linkedPersonId,
    };
