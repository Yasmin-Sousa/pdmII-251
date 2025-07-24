import 'package:avaliacao_08/models/character_model.dart';
import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  final CharacterModel character;
  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(character.img, width: 120, height: 120,),
        Expanded(child: Column(children: [Text(character.name), Text(character.description)]))
      ],
    );
  }
}
