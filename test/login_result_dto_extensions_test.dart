import 'package:amigoapp/src/dto/login_result_dto.dart';
import 'package:amigoapp/src/dto/secret_account_dto.dart';
import 'package:amigoapp/src/dto/token_result_dto.dart';
import 'package:amigoapp/src/extension/login_result_dto_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('login result dto extension tests', () {
    test('conversion from dto to secure storage string returns valid string',
        () {
      final LoginResultDto resultDto = LoginResultDto(
        SecretAccountDto(
          'test-id',
          'test@email.org',
          'changetoken',
          DateTime.parse('2021-10-04T17:33:32.736107'),
          const [],
        ),
        TokenResultDto(
          'token',
          'subject',
          DateTime.parse('2021-10-04T17:33:32.736107'),
          DateTime.parse('2021-10-04T17:33:32.736107'),
          'issuer',
        ),
        TokenResultDto(
          'token',
          'subject',
          DateTime.parse('2021-10-04T17:33:32.736107'),
          DateTime.parse('2021-10-04T17:33:32.736107'),
          'issuer',
        ),
      );
      expect(resultDto.toSecureStorageString(),
          '{"account":{"id":"test-id","email":"test@email.org","changeAccountToken":"changetoken","changeAccountTokenCreatedAt":"2021-10-04T17:33:32.736107","persons":[]},"refreshToken":{"token":"token","subject":"subject","issuedAt":"2021-10-04T17:33:32.736107","expiration":"2021-10-04T17:33:32.736107","issuer":"issuer"},"accessToken":{"token":"token","subject":"subject","issuedAt":"2021-10-04T17:33:32.736107","expiration":"2021-10-04T17:33:32.736107","issuer":"issuer"}}');
    });

    test('conversion from secure storage string to dto returns valid dto', () {
      final LoginResultDto resultDto = LoginResultDto(
        SecretAccountDto(
          'test-id',
          'test@email.org',
          'changetoken',
          DateTime.parse('2021-10-04T17:33:32.736107'),
          const [],
        ),
        TokenResultDto(
          'token',
          'subject',
          DateTime.parse('2021-10-04T17:33:32.736107'),
          DateTime.parse('2021-10-04T17:33:32.736107'),
          'issuer',
        ),
        TokenResultDto(
          'token',
          'subject',
          DateTime.parse('2021-10-04T17:33:32.736107'),
          DateTime.parse('2021-10-04T17:33:32.736107'),
          'issuer',
        ),
      );
      LoginResultDto? convertedDto =
          LoginResultDtoExtensions.fromSecureStorageString(
              '{"account":{"id":"test-id","email":"test@email.org","changeAccountToken":"changetoken","changeAccountTokenCreatedAt":"2021-10-04T17:33:32.736107","persons":[]},"refreshToken":{"token":"token","subject":"subject","issuedAt":"2021-10-04T17:33:32.736107","expiration":"2021-10-04T17:33:32.736107","issuer":"issuer"},"accessToken":{"token":"token","subject":"subject","issuedAt":"2021-10-04T17:33:32.736107","expiration":"2021-10-04T17:33:32.736107","issuer":"issuer"}}');
      expect(convertedDto!, resultDto);
    });
  });
}
