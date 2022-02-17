import 'dart:io';

import 'package:amigoapp/src/core/auth/register/register_summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPhotoScreen extends StatefulWidget {
  static const routeName = '/register/photo';

  final RegisterSummaryArguments summaryArguments;

  const RegisterPhotoScreen({Key? key, required this.summaryArguments})
      : super(key: key);

  @override
  State<RegisterPhotoScreen> createState() => _RegisterPhotoScreenState();
}

class _RegisterPhotoScreenState extends State<RegisterPhotoScreen> {
  XFile? _image;
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      _image = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zurück'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 3,
              width: (MediaQuery.of(context).size.width / 3) * 3,
              color: const Color(0xffffba5f),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(height: 25),
                Text(
                  'Möchtest du ein Bild hochladen?',
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Deine Familie freut sich bestimmt ein Foto von dir zu sehen.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Container(height: 25),
                GestureDetector(
                  onTap: () => getImage(ImageSource.gallery),
                  child: CircleAvatar(
                    child: SizedBox(
                      width: 240,
                      height: 180,
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 180,
                              child: ClipOval(
                                child: _image != null
                                    ? Image.file(File(_image!.path))
                                    : Image.asset(
                                        'assets/images/figma/image-light.png'),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const Alignment(1, 0.35),
                            child: Image.asset(
                                'assets/images/figma/icon-edit.png'),
                          ),
                        ],
                      ),
                    ),
                    radius: 90,
                  ),
                ),
                Container(height: 50),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: _image != null
                            ? () {
                                final _newArgs = RegisterSummaryArguments(
                                  widget.summaryArguments.name,
                                  widget.summaryArguments.email,
                                  widget.summaryArguments.password,
                                  _image != null ? File(_image!.path) : null,
                                );
                                Navigator.of(context).pushNamed(
                                    RegisterSummaryScreen.routeName,
                                    arguments: _newArgs);
                              }
                            : null,
                        child: const Text(
                          'Abschließen',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              RegisterSummaryScreen.routeName,
                              arguments: widget.summaryArguments);
                        },
                        child: const Text('Überspringen'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
