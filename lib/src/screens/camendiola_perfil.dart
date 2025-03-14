import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// Crear un Snippet en Visual Studio Code
// Ctrl+Shift+P
// En la paleta de comandos, busca y selecciona
// Preferences: Configure User Snippets (Configurar fragmentos de usuario).
// New Global Snippets file
class CamendiolaPerfil extends StatefulWidget {
  const CamendiolaPerfil({super.key});
  State<CamendiolaPerfil> createState() => _CamendiolaPerfil();
}

class _CamendiolaPerfil extends State<CamendiolaPerfil> {
  bool valor = false;
  var logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
            top: 50, left: 10, right: 10, bottom: 5), // Ajuste aquí
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              width: 250,
              height: 250,
              child: const Image(
                image: AssetImage('assets/images/icon_man_user.png'),
                fit: BoxFit.cover,
              ),
            ),
            const Center(
              child: Text('CAMENDIOLA',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
            const Center(
              child: Text('Desarrollador Moviles',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  autofocus: true,
                  checkColor: Colors.white,
                  activeColor: Colors.deepOrange,
                  value:
                      valor, // Se utiliza la variable valor para el estado del Checkbox
                  onChanged: (value) {
                    setState(() {
                      valor = value!; // Actualizamos el estado de valor
                    });
                    logger.d("Valor: $valor");
                    print(valor);
                  },
                ),
                const Text('Mis Datos',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 5),
              padding: EdgeInsets.all(
                  10), // Agrega un poco de espacio alrededor del texto
              width: 350,
              decoration: BoxDecoration(
                color: Colors.grey[200], // Color de fondo
                borderRadius: BorderRadius.circular(8), // Bordes redondeados
                border: Border.all(color: Colors.grey, width: 1), // Borde gris
              ),
              child: Text(
                'Un desarrollador móvil es un profesional especializado en la creación y desarrollo '
                'de aplicaciones para dispositivos móviles, como teléfonos inteligentes y tabletas. '
                'Este tipo de desarrollador se enfoca principalmente en la programación y el diseño '
                'de aplicaciones para plataformas como iOS (Apple) y Android (Google).',
                style: TextStyle(fontSize: 14, color: Colors.black),
                overflow: TextOverflow
                    .ellipsis, // Esto asegura que el texto no se salga si es demasiado largo
                maxLines: 15, // Limita el número de líneas de texto
                textAlign: TextAlign.justify, // Alinea el texto a la izquierda
              ),
            ),
          ],
        ),
      ),
    );
  }
}
