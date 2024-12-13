import 'package:flutter/material.dart';

class BasicDesignScreen extends StatelessWidget {
  const BasicDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Imagen Header
          SizedBox(
            width: double.infinity,
            child: Image(
                image: AssetImage('assets/images/landscape.jpg'),
                fit: BoxFit.fitWidth),
          ),

          //Titulo
          Title(),

          //Button Section
          SectionButtom(),
          //Descripcion
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
                'Ash es un personaje central en casi todas las series de Pokémon, incluyendo las películas de Pokémon, y aunque en los videojuegos de la serie principal, el personaje principal generalmente no es él (sino el jugador), en los juegos de la serie Pokémon: Lets Go y algunos otros, Ash aparece como parte de la trama o en contenido adicional.'),
          )
        ],
      ),
    );
  }
}

class SectionButtom extends StatelessWidget {
  const SectionButtom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomBottom(icon: Icons.call, text: 'Llamar'),
          CustomBottom(
            icon: Icons.location_on,
            text: 'Ruta',
          ),
          CustomBottom(
            icon: Icons.share,
            text: 'Compartir',
          ),
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

class Title extends StatelessWidget {
  const Title({
    super.key,
  });

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
                'Villa Paleta',
                style: TextStyle(color: Colors.black45),
              ),
            ],
          ),
          Expanded(child: Container()),
          Icon(
            Icons.star,
            color: Colors.red,
          ),
          Text('001')
        ],
      ),
    );
  }
}
