import 'dart:convert';

import 'package:avaliacao_08/models/character_model.dart';
import 'package:http/http.dart' as http;

class CharactersService {
  final Uri apiURI = Uri.parse(
    "https://www.demonslayer-api.com/api/v1/characters?limit=45",
  );

  Future<List<CharacterModel>> getCharacters() async {
    try {
      final response = await http.get(apiURI);
      final Map<String, dynamic> body = jsonDecode(response.body);
      print(body);
      List<CharacterModel> characters = [];
      for (var character in body["content"]) {
        characters.add(CharacterModel.fromJson(character));
      }
      return characters;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
