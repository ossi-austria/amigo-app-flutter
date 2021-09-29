import 'package:amigo_flutter/src/dto/person_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'secret_account_dto.g.dart';

@JsonSerializable()
class SecretAccountDto extends Equatable {
  final String id;
  final String email;
  final String? changeAccountToken;
  final DateTime? changeAccountTokenCreatedAt;
  final List<PersonDto> persons;

  const SecretAccountDto(this.id, this.email, this.changeAccountToken,
      this.changeAccountTokenCreatedAt, this.persons);

  static const fromJson = _$SecretAccountDtoFromJson;

  Map<String, dynamic> toJson() => _$SecretAccountDtoToJson(this);

  @override
  List<Object?> get props =>
      [id, email, changeAccountToken, changeAccountTokenCreatedAt, persons];
}
