import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickalert/quickalert.dart';

class RegistrarUsuario extends StatelessWidget {
  final TextEditingController txtEmailController = TextEditingController();
  final TextEditingController txtPasswordController = TextEditingController();
  final List<String> roles = ['Paciente', 'Doctor', 'Administrador'];
  String selectedRole = 'Paciente';

  void fnRegister(BuildContext context) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: txtEmailController.text,
        password: txtPasswordController.text,
      );
      User? user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user.uid)
            .set({
          'correo': txtEmailController.text,
          'rol': selectedRole,
        });

        // Show success message using QuickAlert
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Registro Exitoso',
          text: 'Usuario registrado correctamente.',
        );

        // Navigate back to login screen (assuming login is the previous route)
        // This will pop the current screen and go back to the login screen
        Navigator.of(context).pop();
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Error',
          text: 'No se pudo crear el usuario',
        );
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'No se pudo crear el usuario',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Usuario'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: txtEmailController,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: txtPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField(
                value: selectedRole,
                items: roles.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedRole = value.toString();
                },
                decoration: InputDecoration(
                  labelText: 'Selecciona un rol',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  fnRegister(context);
                },
                child: Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
