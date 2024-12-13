import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:testapp/infrastructure/models/pokemon.dart';

class Pokeapi extends StatefulWidget {
  const Pokeapi({super.key});

  @override
  State<Pokeapi> createState() => _PokeapiState();
}

class _PokeapiState extends State<Pokeapi> {
  Pokemon? pokemon; // varibale cualquier cosa, algo como var
  int pokemonId = 0;

  @override
  void initState() {
    super.initState();
    getPokemon();
  }

  Future<void> getPokemon() async {
    pokemonId++;
    //Http. Dio pakage
    //'https://pokeapi.co/api/v2/';
    final respnse =
        await Dio().get('https://pokeapi.co/api/v2/pokemon/$pokemonId');

    pokemon = Pokemon.fromJson(respnse.data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peticion Http'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(pokemon?.name ?? 'No data'),
            if (pokemon != null) ...[
              Image.network(pokemon!.sprites.frontDefault),
              Image.network(pokemon!.sprites.backDefault)
            ]
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.navigate_next),
        onPressed: () {
          getPokemon();
        },
      ),
    );
  }
}
