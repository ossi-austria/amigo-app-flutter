import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_nfc_info_request.g.dart';

@JsonSerializable()
class CreateNfcInfoRequest extends Equatable {
  final String name;
  final String nfcRef;
  final String ownerId;
  final String creatorId;

  const CreateNfcInfoRequest(
      this.name, this.nfcRef, this.ownerId, this.creatorId);

  static const fromJson = _$CreateNfcInfoRequestFromJson;

  Map<String, dynamic> toJson() => _$CreateNfcInfoRequestToJson(this);

  @override
  List<Object?> get props => [name, nfcRef, ownerId, creatorId];
}
