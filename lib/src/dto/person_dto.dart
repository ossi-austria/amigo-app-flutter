import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../app_constants.dart';

part 'person_dto.g.dart';

enum MembershipType { OWNER, ADMIN, ANALOGUE, MEMBER }

@JsonSerializable()
class PersonDto extends Equatable {
  final String id;
  final String name;
  final String? groupId;
  final MembershipType memberType;
  final String? avatarUrl;

  const PersonDto(
      this.id, this.name, this.groupId, this.memberType, this.avatarUrl);

  static const fromJson = _$PersonDtoFromJson;

  Map<String, dynamic> toJson() => _$PersonDtoToJson(this);

  String? absoluteAvatarUrl() {
    if (avatarUrl != null && avatarUrl?.contains('://') == true) {
      return avatarUrl;
    } else {
      return BuildConfig.API_ENDPOINT + 'persons/$id/public/$avatarUrl';
    }
  }

  //  fun absoluteAvatarUrl() = if (!avatarUrl.isNullOrBlank()) {
  //         if (avatarUrl.contains("://")) {
  //             avatarUrl
  //         } else {
  //             BuildConfig.API_ENDPOINT + "persons/$id/public/$avatarUrl"
  //         }
  //     } else null

  @override
  List<Object?> get props => [id, name, groupId, memberType, avatarUrl];
}
