import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int _selectedIndex = 0; //menu de la barra seleccionado el 0

  //Menus
  final List<Widget> _pages = [
    Inicio(),
    Center(child: Text("Calendario")),
    ContactCard(
      name: "Agustin Morales",
      email: "L18540431@gmail.com",
    ),
  ];
  //alert
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
                Navigator.of(context).pop();
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


      body: _pages[_selectedIndex],//pagina actual
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          //Botón 1
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
        currentIndex: _selectedIndex,//item slected
        onTap: (index) {
          _onItemTapped(index);
          //calendario - fecha seleccionada
          if (index == 1) {
            _showDatePicker(context);
          }//clic
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //alert
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

//contacto 
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
//lista
class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int _selectedIndex = -1;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _articuloController = TextEditingController();
  final List<Articulo> _listaArticulos = [];

  void _agregarArticulo() {
    if (_formKey.currentState!.validate()) {
      final nombreArticulo = _articuloController.text;
      setState(() {
        _listaArticulos.add(Articulo(nombreArticulo, false));
        _articuloController.clear();
      });
    }
  }
//dato para agregar
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _articuloController,
                decoration: InputDecoration(
                  labelText: 'Agregue un dato',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                  return 'dato vació';
                  }

                  return null;
                },
              ),
            ),
            ElevatedButton(
              onPressed: _agregarArticulo,
              child: Text('Agregar dato'),
            ),
            SizedBox(height: 20),
            Text('!Lista datos agregados, al cambiar o salir de esta pantalla se borrará toda la lista'),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _listaArticulos.length,
              itemBuilder: (context, index) {
                final articulo = _listaArticulos[index];
                return ListTile(
                  leading: Radio(
                    value: index,
                    groupValue: _selectedIndex,
                    onChanged: (value) {
                      setState(() {
                        _selectedIndex = value!;
                      });
                    },
                  ),
                  title: Text(articulo.nombre),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _listaArticulos.removeAt(index);
                        if (index == _selectedIndex) {
                          _selectedIndex = -1;
                        } else if (index < _selectedIndex) {
                          _selectedIndex--;
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Articulo {
  String nombre;
  bool seleccionado;

  Articulo(this.nombre, this.seleccionado);
}

void main() {
  runApp(MaterialApp(
    home: Principal(),
  ));
}
