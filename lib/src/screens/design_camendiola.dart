import 'package:flutter/material.dart';
import 'package:testapp/src/screens/basic_design.dart';
import 'package:testapp/src/screens/camendiola_perfil.dart';
import 'package:testapp/services/pokedex.dart';

class CaMendiola extends StatefulWidget {
  const CaMendiola({Key? key}) : super(key: key);

  @override
  State<CaMendiola> createState() => _CaMendiola();
}

class _CaMendiola extends State<CaMendiola> {
  // Variable para mantener el contenido seleccionado
  Widget currentPage = const BasicDesignScreen();
  int selectedIndex = 0; // Índice para saber qué ítem está seleccionado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _MenuAppBar(),
      drawer: _DrawerMenuHome(
        onMenuItemSelected: (Widget page, int index) {
          setState(() {
            currentPage = page;
            selectedIndex = index; // Actualiza el índice del ítem seleccionado
          });
        },
        selectedIndex: selectedIndex, // Pasa el índice seleccionado al Drawer
      ),
      body:
          currentPage, // Aquí mostramos el contenido que cambia según la selección
    );
  }
}

class _DrawerMenuHome extends StatelessWidget {
  final Function(Widget, int) onMenuItemSelected;
  final int selectedIndex; // Para saber qué ítem está seleccionado

  const _DrawerMenuHome(
      {super.key,
      required this.onMenuItemSelected,
      required this.selectedIndex});

  void _mostrarDialogo(BuildContext context, String titulo, String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo,
              style: TextStyle(fontSize: 20, color: Colors.deepOrange)),
          content: Text(mensaje,
              style: TextStyle(fontSize: 16, color: Colors.black)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('Aceptar'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Aceptar'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepOrange,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: ClipOval(
                    child: Container(
                      color: Colors.white, // Fondo blanco
                      child: const Image(
                        image: AssetImage('assets/images/icon_man_user.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  child: Text(
                    'Bienvenido',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home,
            title: 'Home',
            index: 0,
            context: context,
          ),
          _buildDrawerItem(
            icon: Icons.catching_pokemon,
            title: 'Pokedex',
            index: 1,
            context: context,
          ),
          _buildDrawerItem(
            icon: Icons.account_circle,
            title: 'Perfil',
            index: 2,
            context: context,
          ),
          _buildDrawerItem(
            icon: Icons.exit_to_app,
            title: 'Cerrar sesión',
            index: 3,
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required int index,
    required BuildContext context,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: selectedIndex == index ? Colors.deepOrangeAccent : Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color:
              selectedIndex == index ? Colors.deepOrangeAccent : Colors.black,
        ),
      ),
      onTap: () {
        // Actualiza el índice y selecciona la página correspondiente
        Widget page;
        switch (index) {
          case 0:
            page = const BasicDesignScreen();
            break;
          case 1:
            page = const MiPokedex();
            break;
          case 2:
            page = const CamendiolaPerfil();
            break;
          default:
            page = const BasicDesignScreen();
        }
        onMenuItemSelected(
            page, index); // Cambia el contenido y resalta el ítem
        Navigator.pop(context); // Cerrar el Drawer
      },
    );
  }
}

class _MenuAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepOrange,
      title: const Text('CaMendiola',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: Icon(
          Icons.menu,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.attribution_rounded,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_sharp, color: Colors.white)),
      ],
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight); // Devuelve el tamaño preferido
}
