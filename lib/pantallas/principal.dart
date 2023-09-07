import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int _selectedIndex = 0; // menu de barra seleccionado el 0

  // menus
  final List<Widget> _pages = [
    
    Center(child: Text("Inicio")),
    Center(child: Text("pagina2")),
    Center(child: Text("p3")),
  ];

  // alerta
  Future<void> _showAlertDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("No Toque!"),
          content: Text("¿Tendré que seguirlo todo el día?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el cuadro de diálogo
              },
              child: Text("¡Espera Jeffrey, tengo que tocarte!"),
            ),
          ],
        );
      },
    );
  }

  // cambiar menus
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AgustinMorales App - muchas cosas wu!"),
      ),
      body: _pages[_selectedIndex], // mostrar pagina actual
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          //boton de navegación 1
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
              //boton de navegación 2
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_emotions),
            label: 'pagina1',
          ),
              //boton de navegación 3
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_emotions),
            label: 'pagina2',
          ),
        ],
        currentIndex: _selectedIndex, // menu seleccionado
        onTap: _onItemTapped, // clic en un ítem
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //cuadro de dialog
          _showAlertDialog(context);
        },
        child: 
        Text("Tocar"),
       
      ),
    );
  }
}