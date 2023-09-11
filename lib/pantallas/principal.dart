import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int _selectedIndex = 0; // menu de la barra seleccionado el 0

  // Menus
  final List<Widget> _pages = [
    Center(child: Text("Inicio")),
    Center(child: Text("calendario")),
    ContactCard(
      name: "Agustin Morales",
      email: "L18540431@gmail.com",
    ),
  ];

  // alert
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
                Navigator.of(context).pop(); // cierra el cuadro de alert
              },
              child: Text("¡Espera Jeffrey, tengo que tocarte!"),
            ),
          ],
        );
      },
    );
  }

  // funcion para mostrar el DatePicker
  Future<void> _showDatePicker(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      // fecha seleccionada
      print('Fecha seleccionada: $picked');
    }
  }

  // cambiar menu
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text(
                'Menu deslizable',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),




            //lista de botones del menpu
            ListTile(
              title: Text('Inicio'),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Calendario'),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
                _showDatePicker(context);
              },
            ),
            ListTile(
              title: Text('Contacto'),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),






      body: _pages[_selectedIndex], // pagina actual
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          // Botón 1
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          // Botón 2
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendario',
          ),
          // Botón 3
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: 'Contacto',
          ),
        ],
        currentIndex: _selectedIndex, // item selected
        onTap: (index) {
          _onItemTapped(index);

          // calendario - fecha seleccionada
          if (index == 1) {
            _showDatePicker(context);
          }
        }, // clic
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // alert
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

  const ContactCard({Key? key, required this.name, required this.email})
      : super(key: key);

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                  ),
                ],
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
