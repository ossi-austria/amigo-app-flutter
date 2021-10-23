import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_nfc_info_request.g.dart';

@JsonSerializable()
class ChangeNfcInfoRequest extends Equatable {
  final String? name;
  final String? linkedAlbumId;
  final String? linkedPersonId;

  const ChangeNfcInfoRequest(
      this.name, this.linkedAlbumId, this.linkedPersonId);

  static const fromJson = _$ChangeNfcInfoRequestFromJson;

  Map<String, dynamic> toJson() => _$ChangeNfcInfoRequestToJson(this);

  @override
  List<Object?> get props => [name, linkedAlbumId, linkedPersonId];
}
