import 'package:flutter/material.dart';
import 'package:app_consultorio/screens/consultorios.dart';
import 'package:app_consultorio/screens/medicamentos.dart';
import 'package:app_consultorio/screens/especialidades.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido Administrador'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Consultorios()),
                );
              },
              child: const Text('Administrar Consultorios'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Medicamentos()),
                );
              },
              child: const Text('Administrar Medicamentos'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Especialidades()),
                );
              },
              child: const Text('Administrar Especialidades'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Doctores()),
                );*/
              },
              child: const Text('Administrar Doctores'),
            ),
          ],
        ),
      ),
    );
  }
}
