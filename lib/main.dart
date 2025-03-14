import 'package:flutter/material.dart';
import 'package:testapp/src/screens/basic_design.dart';
import 'package:testapp/src/screens/design_camendiola.dart';
import 'package:testapp/src/screens/scroll_design.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'design_camendiola',
      routes: {
        'basic_design': (BuildContext context) => BasicDesignScreen(),
        'design_camendiola': (BuildContext context) => CaMendiola(),
        'scroll_screen': (_) => ScrollScreen()
      },
    );
  }
}
 

/*import 'package:flutter/material.dart';
import 'package:testapp/services/pokeapi.dart';
//import 'package:testapp/views/counter_screen.dart';
//import 'package:testapp/views/home_screen.dart';
//import 'package:testapp/views/home_screen.dart';
/*
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomeScreen(),
      //  home: CounterScreen(),
      home: Pokeapi(),
    );
  }
}
*/