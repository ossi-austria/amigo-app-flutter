import 'package:amigoapp/src/dto/person_dto.dart';
import 'package:amigoapp/src/service/api/profile_api_service.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileApiService _profileApiService;

  ProfileProvider(this._profileApiService);

  late PersonDto _currentProfile;

  PersonDto get currentProfile => _currentProfile;

  Future<PersonDto> getOwnProfile() async {
    final profileResponse = await _profileApiService.getOwnProfile();
    if (!profileResponse.isSuccessful) {
      return Future.error('Cannot load own profileResponse');
    }
    _currentProfile = profileResponse.body!;
    notifyListeners();
    return profileResponse.body!;
  }
}
