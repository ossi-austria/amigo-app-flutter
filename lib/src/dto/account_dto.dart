import 'package:amigo_flutter/src/dto/person_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_dto.g.dart';

@JsonSerializable()
class AccountDto {
  final String id;
  final String email;
  final List<PersonDto> persons;

  AccountDto(this.id, this.email, this.persons);

  static const fromJson = _$AccountDtoFromJson;

  Map<String, dynamic> toJson() => _$AccountDtoToJson(this);
}
