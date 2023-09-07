
import 'package:flutter/material.dart';
import 'package:muchascosaswu/pantallas/principal.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: 'Agustin morales APP',
    theme: ThemeData(useMaterial3: true,),
    
    home: Principal(),
    );
  }
}

