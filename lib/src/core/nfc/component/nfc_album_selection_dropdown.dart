import 'package:amigo_flutter/src/component/custom_dropdown_button.dart';
import 'package:amigo_flutter/src/dto/album_dto.dart';
import 'package:amigo_flutter/src/provider/album_provider.dart';
import 'package:amigo_flutter/src/provider/nfc_provider.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';

class NfcAlbumSelectionDropdown extends StatelessWidget {
  final NfcProvider nfcProvider;
  final AlbumProvider albumProvider;

  const NfcAlbumSelectionDropdown(this.nfcProvider, this.albumProvider,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response<List<AlbumDto>>>(
      future: albumProvider.getOwnAlbums(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final response = snapshot.data!;
          if (response.isSuccessful) {
            List<AlbumDto> albumList = response.body!;
            if (albumList.isEmpty) {
              return const Text('Keine Alben vorhanden');
            } else {
              return CustomDropdownButton<AlbumDto>(
                value: nfcProvider.selectedAlbum,
                onChanged: (value) => nfcProvider.selectAlbum(value),
                items: albumList
                    .map(
                      (e) => DropdownMenuItem(
                        child: Text(e.name),
                        value: e,
                      ),
                    )
                    .toList(),
              );
            }
          } else {
            // TODO: error handling
          }
        }
        return const Text('loading');
      },
    );
  }
}
