import 'package:flutter/material.dart';
import 'package:testapp/infrastructure/models/pokemon_local.dart'; // Importa el modelo de Pokémon

class DetallePokemonScreen extends StatefulWidget {
  final PokemonLocal pokemon; // Recibe el Pokémon como parámetro

  const DetallePokemonScreen({Key? key, required this.pokemon})
      : super(key: key);

  @override
  State<DetallePokemonScreen> createState() => _DetallePokemonScreen();
}

class _DetallePokemonScreen extends State<DetallePokemonScreen> {
  @override
  Widget build(BuildContext context) {
    // Accede al Pokémon pasado desde la navegación
    final pokemon = widget.pokemon;

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name), // Título con el nombre del Pokémon
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Imagen frontal del Pokémon centrada y más grande
            pokemon.frontImage.isNotEmpty
                ? Center(
                    child: Container(
                      width:
                          150, // Puedes ajustar el tamaño máximo de la imagen
                      height: 150, // Ajusta también la altura
                      child: Image.network(
                        pokemon.frontImage,
                        fit: BoxFit
                            .contain, // Usa BoxFit.cover si deseas que la imagen llene todo el espacio
                      ),
                    ),
                  )
                : const Icon(Icons.image_not_supported),

            const SizedBox(height: 16),

            // Detalles del Pokémon
            Text(
              'ID: ${pokemon.id}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Nombre: ${pokemon.name}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),

            // Imagen trasera del Pokémon centrada y más grande
            pokemon.backImage.isNotEmpty
                ? Center(
                    child: Container(
                      width: 100, // Ajusta el tamaño máximo de la imagen
                      height: 100, // Ajusta también la altura
                      child: Image.network(
                        pokemon.backImage,
                        fit: BoxFit
                            .contain, // Usa BoxFit.cover si deseas que la imagen llene todo el espacio
                      ),
                    ),
                  )
                : const Icon(Icons.image_not_supported),
          ],
        ),
      ),
    );
  }
}
