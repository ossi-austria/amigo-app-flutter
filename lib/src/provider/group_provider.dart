import 'package:amigo_flutter/src/dto/group_dto.dart';
import 'package:amigo_flutter/src/dto/person_dto.dart';
import 'package:amigo_flutter/src/service/api/group_api_service.dart';
import 'package:flutter/material.dart';

class GroupProvider with ChangeNotifier {
  final GroupApiService _groupApiService;

  GroupProvider(this._groupApiService);

  PersonDto? _selectedGroupMember;

  PersonDto? get selectedGroupMember => _selectedGroupMember;

  Future<GroupDto> getSelectedGroup() async {
    final groupResponse = await _groupApiService.getMyGroups();
    if (!groupResponse.isSuccessful) {
      // TODO: throw exception and handle it
    }
    return groupResponse.body!.first;
  }

  void selectGroupMember(PersonDto? personDto) {
    _selectedGroupMember = personDto;
    notifyListeners();
  }
}
