import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int _selectedIndex = 0; // menú de la barra seleccionado el 0

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

  // Función para mostrar el DatePicker
  Future<void> _showDatePicker(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      // Aquí puedes hacer algo con la fecha seleccionada
      print('Fecha seleccionada: $picked');
    }
  }

  // Cambiar menu
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
          // Botn 1
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          // Botn 2
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'calendario',
          ),
          // Botn 3
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: 'contacto',
          ),
        ],
        currentIndex: _selectedIndex, // item selected
        onTap: (index) {
          _onItemTapped(index);

          // Agregar manejo específico para el ítem "pagina1"
          if (index == 1) {
            _showDatePicker(context);
          }
        }, // Clic 
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

class ContactCard extends StatefulWidget {
  final String name;
  final String email;

  const ContactCard({Key? key, required this.name, required this.email}) : super(key: key);

  @override
  _ContactCardState createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  bool _isFavorite = false;

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
                    widget.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Checkbox(
                    value: _isFavorite,
                    onChanged: (value) {
                      setState(() {
                        _isFavorite = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                widget.email,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
