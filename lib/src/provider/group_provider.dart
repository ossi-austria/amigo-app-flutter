import 'package:amigoapp/src/dto/group_dto.dart';
import 'package:amigoapp/src/dto/person_dto.dart';
import 'package:amigoapp/src/service/api/group_api_service.dart';
import 'package:flutter/material.dart';

import '../utils/logger.dart';

class GroupProvider with ChangeNotifier {
  GroupProvider(this._groupApiService);

  final GroupApiService _groupApiService;

  final log = getLogger();

  PersonDto? _selectedGroupMember;

  PersonDto? get selectedGroupMember => _selectedGroupMember;

  GroupDto? _selectedGroup;

  GroupDto? get selectedGroup => _selectedGroup;

  void refreshSelectedGroup() async {
    _selectedGroup = await getSelectedGroup();
    notifyListeners();
  }

  Future<GroupDto> getSelectedGroup() async {
    final groupResponse = await _groupApiService.getMyGroups();
    if (!groupResponse.isSuccessful) {
      log.w('getSelectedGroup failed!');
      return Future.error('No Group found for Person');
    }
    log.i('getSelectedGroup response: ${groupResponse.body!.first}');
    return groupResponse.body!.first;
  }

  Future<PersonDto?> getAnalogue() async {
    GroupDto _group = await getSelectedGroup();
    final analogue = _group.analogue;
    return analogue;
  }

  void selectGroupMember(PersonDto? personDto) {
    _selectedGroupMember = personDto;
    notifyListeners();
  }
}
