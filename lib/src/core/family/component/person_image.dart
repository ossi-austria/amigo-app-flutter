import 'package:amigo_flutter/src/dto/person_dto.dart';
import 'package:flutter/material.dart';

enum PersonImageFormat { rounded, rectangle }

class PersonImage extends StatelessWidget {
  final PersonDto personDto;
  final PersonImageFormat personImageFormat;

  const PersonImage(this.personDto,
      {this.personImageFormat = PersonImageFormat.rectangle, Key? key})
      : super(key: key);

  Widget containerWidget(String fallbackImagePath) {
    return Container(
      decoration: BoxDecoration(
        image: personDto.avatarUrl != null
            ? DecorationImage(
                fit: BoxFit.fitWidth,
                alignment: FractionalOffset.topCenter,
                image: NetworkImage(personDto.avatarUrl!))
            : DecorationImage(
                fit: BoxFit.fitWidth,
                alignment: FractionalOffset.topCenter,
                image: AssetImage(fallbackImagePath),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (personImageFormat) {
      case PersonImageFormat.rounded:
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            bottomLeft: Radius.circular(16.0),
          ),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: containerWidget('assets/images/figma/family-dummy.png'),
          ),
        );
      case PersonImageFormat.rectangle:
        return ClipRect(
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: containerWidget(
                'assets/images/figma/person-overview-dummy.png'),
          ),
        );
    }
  }
}
