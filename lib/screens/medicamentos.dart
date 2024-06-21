import 'package:app_consultorio/screens/medicamento.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Medicamentos extends StatefulWidget {
  const Medicamentos({super.key});

  @override
  State<Medicamentos> createState() => _MedicamentosState();
}

class _MedicamentosState extends State<Medicamentos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medicamentos"),
      ),
      body: Center(
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('medicamentos').snapshots(),
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
                  title: Text(doc["codigo"]),
                  subtitle: Text(doc["fecha"]),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Medicamento(
                                docId: doc.id,
                                initialCode: doc["codigo"],
                                initialDescription: doc["descripcion"],
                                initialStock: doc["disponibilidad"],
                                initialDate: DateTime.parse(doc["fecha"]),
                              )),
                    );
                    if (result == 'saved') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Medicamento guardado con éxito')));
                    } else if (result == 'deleted') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Medicamento eliminado con éxito')));
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
            MaterialPageRoute(builder: (context) => Medicamento()),
          );
          if (result == 'saved') {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Medicamento guardado con éxito')));
          }
        },
      ),
    );
  }
}
