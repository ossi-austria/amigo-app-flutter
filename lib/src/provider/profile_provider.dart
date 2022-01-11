import 'package:amigo_flutter/src/dto/person_dto.dart';
import 'package:amigo_flutter/src/service/api/profile_api_service.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileApiService _profileApiService;

  ProfileProvider(this._profileApiService);

  PersonDto? _currentProfile;

  PersonDto? get currentProfile => _currentProfile;

  Future<PersonDto> getOwnProfile() async {
    final profileResponse = await _profileApiService.getOwnProfile();
    if (!profileResponse.isSuccessful) {
      // TODO: throw exception and handle it
    }
    _currentProfile = profileResponse.body!;
    notifyListeners();
    return profileResponse.body!;
  }
}
