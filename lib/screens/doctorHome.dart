import 'package:flutter/material.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido Doctor'),
      ),
      body: const Center(
        child: Text(
          'Bienvenido Doctor',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
