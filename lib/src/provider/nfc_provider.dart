import 'package:amigoapp/src/dto/album_dto.dart';
import 'package:amigoapp/src/dto/change_nfc_info_request.dart';
import 'package:amigoapp/src/dto/create_nfc_info_request.dart';
import 'package:amigoapp/src/dto/nfc_info_dto.dart';
import 'package:amigoapp/src/dto/person_dto.dart';
import 'package:amigoapp/src/provider/profile_provider.dart';
import 'package:amigoapp/src/service/api/nfc_info_api_service.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '../utils/logger.dart';

class NfcProvider with ChangeNotifier {
  final ProfileProvider _profileProvider;
  final NfcInfoApiService _nfcInfoApiService;

  NfcProvider(this._profileProvider, this._nfcInfoApiService);

  final log = getLogger();

  NfcInfoType? _newNfcTag;
  AlbumDto? _selectedAlbum;
  PersonDto? _selectedCallee;
  String? _name;
  String? _id;
  List<NfcInfoDto> _nfcInfoList = [];

  NfcInfoType? get newNfcTag => _newNfcTag;

  AlbumDto? get selectedAlbum => _selectedAlbum;

  PersonDto? get selectedCallee => _selectedCallee;

  String? get name => _name;

  String? get id => _id;

  List<NfcInfoDto> get nfcInfoList => _nfcInfoList;

  bool get stepOneFinished {
    return _newNfcTag == NfcInfoType.CALL_PERSON && _selectedCallee != null ||
        _newNfcTag == NfcInfoType.OPEN_ALBUM && _selectedAlbum != null;
  }

  bool get stepTwoFinished {
    return (_name?.isNotEmpty ?? false) && (_id?.isNotEmpty ?? false);
  }

  void resetNewNfcInfo() {
    _newNfcTag = _selectedAlbum = _selectedCallee = _name = _id = null;
  }

  void selectNfcInfoType(NfcInfoType? nfcInfoType) {
    if (_newNfcTag != nfcInfoType) {
      _selectedAlbum = _selectedCallee = null;
      _newNfcTag = nfcInfoType;
      log.i('NFC selected nfcInfoType $nfcInfoType');
      notifyListeners();
    }
  }

  void selectAlbum(AlbumDto? albumDto) {
    if (_selectedAlbum != albumDto) {
      _selectedAlbum = albumDto;
      _name = 'Album ${albumDto?.name}';
      _id = null;
      log.i('NFC selected Album $albumDto');
      notifyListeners();
    }
  }

  void selectCallee(PersonDto? personDto) {
    if (_selectedCallee != personDto) {
      _selectedCallee = personDto;
      _name = 'Anruf ${personDto?.name}';
      _id = null;
      log.i('NFC selected PersonDto $personDto');
      notifyListeners();
    }
  }

  void setName(String? value) {
    _name = value;
    log.i('NFC setName $value');
    notifyListeners();
  }

  void setId(String? value) {
    _id = value;
    log.i('NFC setId $value');
    notifyListeners();
  }

  Future<void> readNfc({required Function(String) onSuccess, required Function onFailure}) async {
    log.i('NFC readNfc');
    bool nfcAvailable = await NfcManager.instance.isAvailable();
    log.i('NFC nfcAvailable: $nfcAvailable');
    if (nfcAvailable) {
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        Ndef? ndef = Ndef.from(tag);
        log.i('NFC read: $ndef');
        if (ndef != null) {
          final identifierString = ndef.additionalData['identifier'];
          final identifier = hexArrayToString(identifierString);
          log.i('NFC read: $identifier');
          setId(identifier);
          onSuccess(identifier);
        } else {
          log.w('NFC readNfc: failed, no isoDep');
          onFailure();
        }
        NfcManager.instance.stopSession();
      });
    } else {
      log.w('NFC readNfc: failed, not available');
      onFailure();
    }
  }

  Future<void> createNfc() async {
    final profile = await _profileProvider.getOwnProfile();
    final createNfcInfoResponse = await _nfcInfoApiService
        .createNfcInfo(CreateNfcInfoRequest(_name!, _id!, _selectedCallee!.id, profile.id));
    if (!createNfcInfoResponse.isSuccessful) {
      // TODO: throw exception and handle it
      throw (Exception());
    }
    // TODO: create & change should be one atomic operation, or there should be a UI for only retrying the change request
    final changeNfcInfoResponse = await _nfcInfoApiService.changeNfcInfo(
        createNfcInfoResponse.body!.id,
        ChangeNfcInfoRequest(_name, _selectedAlbum?.id, _selectedCallee?.id));
    if (!changeNfcInfoResponse.isSuccessful) {
      // TODO: throw exception and handle it
      throw (Exception());
    }
    _nfcInfoList.add(changeNfcInfoResponse.body!);
    notifyListeners();
  }

  /*Future<List<NfcInfoDto>> getOwnedNfcInfos(PersonDto? personDto) async {
    final nfcInfoResponse = await _nfcInfoApiService.getOwnNfcInfos();
    if (!nfcInfoResponse.isSuccessful) {
      // TODO: throw exception and handle it
    }
    return nfcInfoResponse.body!
        .where((element) => element.ownerId == personDto?.id)
        .toList();
  }*/

  Future<void> getCreatedNfcInfosForPerson(PersonDto personDto) async {
    final nfcInfoResponse = await _nfcInfoApiService.getCreatedNfcInfos();
    if (!nfcInfoResponse.isSuccessful) {
      // TODO: throw exception and handle it
    }
    var ownProfile = await _profileProvider.getOwnProfile();

    _nfcInfoList = nfcInfoResponse.body!.where((element) {
      return element.creatorId == ownProfile.id && element.ownerId == personDto.id;
    }).toList();
    notifyListeners();
  }

  String hexArrayToString(List<int> decimalIntList) {
    final hexList = decimalIntList.map((decimalInt) => decimalInt.toRadixString(16));
    return hexList.join(':');
  }
}
