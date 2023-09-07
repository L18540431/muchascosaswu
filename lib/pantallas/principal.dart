import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  // Función para mostrar el cuadro de diálogo de alerta
  Future<void> _showAlertDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("No Toque!"),
          content: Text("¿Tendré que seguirlo todo el dia?"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AgustinMorales App  muchas cosas wu!"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Llamar a la función para mostrar el cuadro de diálogo
            _showAlertDialog(context);
          },
          child: Text("Tocar"),
        ),
      ),
    );
  }
}