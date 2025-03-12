// Crear un Snippet en Visual Studio Code
// Ctrl+Shift+P
// En la paleta de comandos, busca y selecciona
// Preferences: Configure User Snippets (Configurar fragmentos de usuario).
// New Global Snippets file
import 'package:flutter/material.dart';

class CaMendiola extends StatelessWidget {
  const CaMendiola({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Camendiola'),
      ),
    );
  }
}
