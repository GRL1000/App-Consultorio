import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Especialidad extends StatefulWidget {
  const Especialidad({super.key});

  @override
  State<Especialidad> createState() => _EspecialidadState();
}
class _EspecialidadState extends State<Especialidad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: Text(¨Home¨),
      ),
       
       body: Center(
        child: StreamBuilder(
           stream: FirebaseFirestore.instance.collection()
        )
        )
       }
}
Future<void> _saveData() async {
  //Crear
  FirebaseFirestore.instance
      .collection('especialidades')
      .add({'nombre': _nameController.text});

//Actualizar
  FirebaseFirestore.instance
      .collection('especialidades')
      .doc('')
      .update({'nombre': _nameController.txt});
//Borrar
  FirebaseFirestore.instance.collection('especialidades').doc('').delete();
//MostrarS 
StreamBuilder(

  stream : FiresbaseFirestore.instance.collection('especialidades').snapshots();

)};

class _EspecialidadState extends State<Especialidad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva especialidad'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre de la especialidad',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Acción al presionar el botón
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
