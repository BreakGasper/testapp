import 'package:testapp/infrastructure/models/pokemon.dart';

class PokemonLocal {
  final int id;
  final String name;
  final String frontImage;
  final String backImage;

  PokemonLocal({
    required this.id,
    required this.name,
    required this.frontImage,
    required this.backImage,
  });

  // Constructor para convertir un Pokemon a PokemonLocal
  factory PokemonLocal.fromMap(Pokemon pokemon) {
    return PokemonLocal(
      id: pokemon.id,
      name: pokemon.name,
      frontImage: pokemon.sprites.frontDefault,
      backImage: pokemon.sprites.backDefault,
    );
  }

  // Convertir el PokemonLocal a un Map para la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'frontImage': frontImage,
      'backImage': backImage,
    };
  }
}
