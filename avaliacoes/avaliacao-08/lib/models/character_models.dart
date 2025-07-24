class CharacterModel {
  final int id;
  final String name;
  final int age;
  final String gender;
  final String race;
  final String description;
  final String img;
  final int affiliationId;
  final int arcId;
  final String quote;

  CharacterModel({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.race,
    required this.description,
    required this.img,
    required this.affiliationId,
    required this.arcId,
    required this.quote,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      age: json["age"] ?? 0,
      gender: json["gender"] ?? "",
      race: json["race"] ?? "",
      description: json["description"] ?? "",
      img: json["img"] ?? "",
      affiliationId: json["affiliation_id"] ?? 0,
      arcId: json["arc_id"] ?? 0,
      quote: json["quote"] ?? "",
    );
  }
}
