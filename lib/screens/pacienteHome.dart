import 'package:flutter/material.dart';

class PacienteHome extends StatelessWidget {
  const PacienteHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido Paciente'),
      ),
      body: const Center(
        child: Text(
          'Bienvenido Paciente',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
