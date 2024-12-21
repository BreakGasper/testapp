import 'package:flutter/material.dart';
import 'package:testapp/infrastructure/models/pokemon_local.dart';
import 'package:testapp/services/database_helper.dart';

class MiPokedex extends StatefulWidget {
  const MiPokedex({super.key});

  @override
  State<MiPokedex> createState() => _MiPokedexState();
}

class _MiPokedexState extends State<MiPokedex> {
  List<PokemonLocal> pokemons =
      []; // Lista para almacenar todos los Pokémon obtenidos de la base de datos

  @override
  void initState() {
    super.initState();
    obtenerPokemons(); // Cargar los Pokémon al iniciar el estado
  }

  // Método para obtener todos los Pokémon de la base de datos
  void obtenerPokemons() async {
    DatabaseHelper dbHelper = DatabaseHelper();

    // Obtén todos los registros de la tabla 'pokemon'
    List<Map<String, dynamic>> pokemonsData =
        await dbHelper.queryAll('pokemon');

    // Convierte los registros de la base de datos en una lista de objetos PokemonLocal
    setState(() {
      pokemons = pokemonsData
          .map((pokemonData) => PokemonLocal(
                id: pokemonData['id'],
                name: pokemonData['name'],
                frontImage: pokemonData['frontImage'],
                backImage: pokemonData['backImage'],
              ))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pokémon'),
      ),
      body: Center(
        child: pokemons.isEmpty
            ? const CircularProgressIndicator() // Muestra un indicador de carga si no hay Pokémon aún
            : ListView.builder(
                itemCount: pokemons.length, // Número de Pokémon en la lista
                itemBuilder: (context, index) {
                  final pokemon =
                      pokemons[index]; // Obtener el Pokémon en el índice actual
                  return ListTile(
                    title: Text(pokemon.name), // Mostrar el nombre del Pokémon
                    subtitle:
                        Text('ID: ${pokemon.id}'), // Mostrar el ID del Pokémon
                    leading: pokemon.frontImage.isNotEmpty
                        ? Image.network(pokemon
                            .frontImage) // Mostrar la imagen frontal si está disponible
                        : const Icon(Icons.image_not_supported),
                    trailing: pokemon.backImage.isNotEmpty
                        ? Image.network(pokemon
                            .backImage) // Mostrar la imagen trasera si está disponible
                        : const Icon(Icons.image_not_supported),
                  );
                },
              ),
      ),
    );
  }
}
