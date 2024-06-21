import 'package:app_consultorio/screens/consultorio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Consultorios extends StatefulWidget {
  const Consultorios({super.key});

  @override
  State<Consultorios> createState() => _ConsultoriosState();
}

class _ConsultoriosState extends State<Consultorios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consultorios"),
      ),
      body: Center(
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('consultorios').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text("Ha ocurrido un error"));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("Sin registros"));
            }

            List<DocumentSnapshot> docs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot doc = docs[index];

                return ListTile(
                  leading: const Icon(Icons.business),
                  title: Text(doc["nombre"]),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Consultorio(
                              docId: doc.id, initialName: doc["nombre"])),
                    );
                    if (result == 'saved') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Consultorio guardado con éxito')));
                    } else if (result == 'deleted') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Consultorio eliminada con éxito')));
                    }
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Consultorio()),
          );
          if (result == 'saved') {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Consultorio guardada con éxito')));
          }
        },
      ),
    );
  }
}
