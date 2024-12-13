import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
//Propiedades
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const fontSize = TextStyle(fontSize: 30);
    int counter = 10;
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomeScreen'),
          elevation: 5.0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Clicks Counter',
                style: fontSize,
              ),
              Text(
                '$counter',
                style: fontSize,
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            counter++;
            print('Hola Mundo $counter');
          },
        ));
  }
}
