import 'package:flutter/material.dart';
import 'package:testapp/services/pokeapi.dart';
import 'package:testapp/services/pokedex.dart';
import 'package:testapp/services/database_helper.dart';

class BasicDesignScreen extends StatefulWidget {
  const BasicDesignScreen({super.key});

  @override
  State<BasicDesignScreen> createState() => _inicial();
}

class _inicial extends State<BasicDesignScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Imagen Header
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/images/landscape.jpg',
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Pokedex(),
                _CapturePokemon(),
              ],
            ),
          ),
          // Titulo
          PokemonCount(), // Ahora el contador se actualiza dinámicamente
          // Button Section
          SectionButtom(),
          // Descripcion
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
                'Ash es un personaje central en casi todas las series de Pokémon, incluyendo las películas de Pokémon, y aunque en los videojuegos de la serie principal, el personaje principal generalmente no es él (sino el jugador), en los juegos de la serie Pokémon: Lets Go y algunos otros, Ash aparece como parte de la trama o en contenido adicional.'),
          ),
        ],
      ),
    );
  }
}

class _CapturePokemon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: FloatingActionButton(
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
    ));
  }
}

class _Pokedex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FloatingActionButton(
          backgroundColor: Colors.white,
          heroTag: 'fab_capture',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MiPokedex()),
            );
          },
          child: SizedBox(
            width: 40.0,
            height: 40.0,
            child: Image.asset(
              'assets/images/juego.png',
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}

class SectionButtom extends StatelessWidget {
  const SectionButtom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomBottom(icon: Icons.call, text: 'Llamar'),
          CustomBottom(icon: Icons.location_on, text: 'Ruta'),
          CustomBottom(icon: Icons.share, text: 'Compartir'),
        ],
      ),
    );
  }
}

class CustomBottom extends StatelessWidget {
  final IconData icon;
  final String text;

  const CustomBottom({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.blue,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.blue),
        ),
      ],
    );
  }
}

class PokemonCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: DatabaseHelper().getPokemonCountStream(), // Usamos el Stream
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Cargando
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Title(
              pokemonCount:
                  snapshot.data ?? 0); // Muestra el contador actualizado
        }
      },
    );
  }
}

class Title extends StatelessWidget {
  final int pokemonCount;

  const Title({super.key, required this.pokemonCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Región de Kanto',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Pueblo Paleta',
                style: TextStyle(color: Colors.black45),
              ),
            ],
          ),
          Expanded(child: Container()),
          Icon(
            Icons.blur_circular_outlined,
            color: Colors.red,
          ),
          Text(
              '${pokemonCount}') // Muestra la cantidad de Pokemons dinámicamente
        ],
      ),
    );
  }
}
