import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:testapp/infrastructure/models/pokemon.dart';
import 'package:testapp/infrastructure/models/pokemon_local.dart';
import 'package:testapp/services/database_helper.dart';

class Pokeapi extends StatefulWidget {
  const Pokeapi({super.key});

  @override
  State<Pokeapi> createState() => _PokeapiState();
}

class _PokeapiState extends State<Pokeapi> {
  Pokemon? pokemon; // Variable para almacenar el Pokémon
  int pokemonId = 0; // ID del Pokémon

  @override
  void initState() {
    super.initState();
    getPokemon();
  }

  // Función para obtener un Pokémon usando Dio
  Future<void> getPokemon() async {
    Random random = Random();

    pokemonId = random.nextInt(150); // ID aleatorio entre 1 y 999

    //pokemonId++;
    try {
      print('pokemonId ${pokemonId}');
      final response =
          await Dio().get('https://pokeapi.co/api/v2/pokemon/$pokemonId');
      pokemon = Pokemon.fromJson(response.data);
      setState(() {}); // Actualiza el estado cuando se recibe el Pokémon
    } catch (e) {
      print("Error fetching Pokémon: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capturar Pokémon'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              child: AspectRatio(
                aspectRatio: 16 / 9, // Mantiene la relación de aspecto 16:9
                child: ClipRect(
                  child: Image.asset(
                    'assets/images/landscape.jpg',
                    fit: BoxFit
                        .cover, // Ajusta la imagen para que cubra todo el espacio
                  ),
                ),
              ),
            ),
          ),

          Center(
            child: SizedBox(
              width: 600.0, // Ajusta el ancho según tus necesidades
              height: 400.0, // Ajusta la altura según tus necesidades
              child: Image.asset(
                'assets/images/landscape.jpg',
                fit: BoxFit
                    .cover, // Ajusta la imagen para que cubra todo el espacio
              ),
            ),
          ),

          // Contenido principal
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  pokemon?.name ?? 'No data',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Texto más visible sobre el fondo
                  ),
                ),
                if (pokemon != null) ...[
                  SizedBox(
                    width: 125.0, // Ajusta el ancho según tus necesidades
                    height: 125.0, // Ajusta la altura según tus necesidades
                    child: Image.network(
                      pokemon!.sprites.frontDefault,
                      fit: BoxFit
                          .cover, // Ajusta la imagen para cubrir el contenedor
                    ),
                  ),
                  SizedBox(
                    width: 125.0, // Ajusta el ancho según tus necesidades
                    height: 125.0, // Ajusta la altura según tus necesidades
                    child: Image.network(
                      pokemon!.sprites.backDefault,
                      fit: BoxFit
                          .cover, // Ajusta la imagen para cubrir el contenedor
                    ),
                  ),
                ],
                FloatingActionButton(
                    onPressed: () {
                      getPokemon();
                    },
                    child: const Icon(Icons.arrow_circle_right_sharp)),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        heroTag: 'uniqueTag', // Etiqueta única para el botón flotante
        onPressed: () {
          addPokemonToDatabase();
        },
        child: Image.asset(
          'assets/images/pokebola.png', // Ruta de tu imagen personalizada
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Función para agregar el Pokémon a la base de datos
  void addPokemonToDatabase() async {
    Random random = Random();
    int capture = random.nextInt(3);
    if (capture == 1) {
      if (pokemon != null) {
        final dbHelper = DatabaseHelper();

        // Convertir el Pokémon a PokemonLocal
        PokemonLocal pokemonLocal = PokemonLocal.fromMap(pokemon!);

        // Insertar el Pokémon en la base de datos con manejo de conflictos
        await dbHelper.insertWithConflictResolution(
            'pokemon', pokemonLocal.toMap());

        // Mostrar un mensaje de confirmación
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.green,
              content:
                  Text('Capturaste a ${pokemon!.name} añadido a la Pokédex')),
        );

        getPokemon();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('${pokemon!.name} a escapado, intenta de nuevo')));
      getPokemon();
      return;
    }
  }
}
