import 'package:avaliacao_08/models/character_model.dart';
import 'package:avaliacao_08/services/characters_service.dart';
import 'package:avaliacao_08/views/characters/character_card.dart';
import 'package:flutter/material.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  List<CharacterModel> characters = [];

  @override
  void initState() {
    getCharacters();
    super.initState();
  }

  Future<void> getCharacters() async {
    final CharactersService charactersService = CharactersService();
    List<CharacterModel> charactersList = await charactersService
        .getCharacters();
    setState(() {
      characters = charactersList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Characters Demon Slayer")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: characters.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CharacterCard(character: characters[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
