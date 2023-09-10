import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int _selectedIndex = 0; // menú de la barra seleccionado el 0

  // Menús
  final List<Widget> _pages = [
    Center(child: Text("Inicio")),
    Center(child: Text("contact")),
    ContactCard(
      name: "Agustin Morales",
      email: "L18540431@gmail.com",
    ),
  ];

  // Alerta
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

  // Cambiar menús
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
      body: _pages[_selectedIndex], // Mostrar página actual
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          // Botón de navegación 1
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          // Botón de navegación 2
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_emotions),
            label: 'pagina1',
          ),
          // Botón de navegación 3
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: 'contacto',
          ),
        ],
        currentIndex: _selectedIndex, // Menú seleccionado
        onTap: _onItemTapped, // Clic en un ítem
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Cuadro de diálogo
          _showAlertDialog(context);
        },
        child: Text("Tocar"),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final String name;
  final String email;

  const ContactCard({Key? key, required this.name, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                email,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
