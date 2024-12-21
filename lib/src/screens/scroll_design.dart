import 'package:flutter/material.dart';
import 'package:testapp/src/screens/basic_design.dart';

class ScrollScreen extends StatelessWidget {
  const ScrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.lightBlueAccent, Color(0xff006f72)])),
      child: PageView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [_Page1(), _Button()],
      ),
    ));
  }
}

class _Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_Background(), _MainContent()],
    );
  }
}

class _MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
        fontSize: 60, fontWeight: FontWeight.bold, color: Colors.black);
    return SafeArea(
      bottom: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            '32°',
            style: textStyle,
          ),
          Text(
            'Jueves',
            style: textStyle,
          ),
          Expanded(child: Container()),
          Icon(
            Icons.keyboard_arrow_down,
            size: 100,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff006f72),
      height: double.infinity,
      alignment: Alignment.topCenter,
      child: Image(
        image: AssetImage('assets/images/portaitscape.jpg'),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff006f72),
      child: Center(
          child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BasicDesignScreen()), // Pantalla2 es la pantalla destino
                );
              },
              // ignore: sort_child_properties_last
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text('Bienvenido',
                    style: TextStyle(color: Colors.white, fontSize: 30)),
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blueAccent, shape: StadiumBorder()))),
    );
  }
}
