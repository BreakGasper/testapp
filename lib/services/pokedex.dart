import 'package:flutter/material.dart';
import 'package:testapp/infrastructure/models/pokemon_local.dart';
import 'package:testapp/services/database_helper.dart';
import 'package:testapp/services/pokeapi.dart';
import 'package:testapp/src/screens/detallePokemon.dart';

class MiPokedex extends StatefulWidget {
  const MiPokedex({super.key});

  @override
  State<MiPokedex> createState() => _MiPokedexState();
}

class _MiPokedexState extends State<MiPokedex> {
  List<PokemonLocal> pokemons =
      []; // Lista de Pokémon obtenidos de la base de datos
  List<PokemonLocal> filteredPokemons = []; // Lista filtrada de Pokémon
  TextEditingController searchController =
      TextEditingController(); // Controlador para el campo de búsqueda

  @override
  void initState() {
    super.initState();
    obtenerPokemons(); // Cargar los Pokémon al iniciar el estado

    // Escuchar cambios en el campo de búsqueda
    searchController.addListener(() {
      filterPokemons();
    });
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

      // Inicializamos la lista filtrada con todos los Pokémon al principio
      filteredPokemons = pokemons;
    });
  }

  // Método para filtrar los Pokémon según el texto ingresado
  void filterPokemons() {
    String query = searchController.text.toLowerCase();

    // Filtra los Pokémon por nombre
    setState(() {
      filteredPokemons = pokemons
          .where((pokemon) =>
              pokemon.name.toLowerCase().contains(query)) // Filtra por nombre
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pokémon'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller:
                  searchController, // Asocia el controlador al campo de búsqueda
              decoration: InputDecoration(
                labelText: 'Buscar Pokémon',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.white,
            heroTag: 'fab_capture',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Pokeapi()),
              );
            },
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: Image.asset(
                'assets/images/cerrar.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: filteredPokemons.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: filteredPokemons
                        .length, // Número de Pokémon en la lista filtrada
                    itemBuilder: (context, index) {
                      final pokemon = filteredPokemons[
                          index]; // Obtener el Pokémon en el índice actual
                      return ListTile(
                        title:
                            Text(pokemon.name), // Mostrar el nombre del Pokémon
                        subtitle: Text(
                            'ID: ${pokemon.id}'), // Mostrar el ID del Pokémon
                        leading: pokemon.frontImage.isNotEmpty
                            ? Image.network(pokemon
                                .frontImage) // Mostrar la imagen frontal si está disponible
                            : const Icon(Icons.image_not_supported),
                        trailing: pokemon.backImage.isNotEmpty
                            ? Image.network(pokemon
                                .backImage) // Mostrar la imagen trasera si está disponible
                            : const Icon(Icons.image_not_supported),
                        onTap: () {
                          // Navegar a la pantalla de detalles y pasar el Pokémon seleccionado
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetallePokemonScreen(pokemon: pokemon),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
