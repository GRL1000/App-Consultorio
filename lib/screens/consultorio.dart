import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Consultorio extends StatefulWidget {
  final String? docId;
  final String? initialName;
  const Consultorio({Key? key, this.docId, this.initialName}) : super(key: key);

  @override
  State<Consultorio> createState() => _ConsultorioState();
}

class _ConsultorioState extends State<Consultorio> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialName != null) {
      _nameController.text = widget.initialName!;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      if (widget.docId == null) {
        // Crear
        await FirebaseFirestore.instance.collection('consultorios').add({
          'nombre': _nameController.text,
        });
      } else {
        // Actualizar
        await FirebaseFirestore.instance
            .collection('consultorios')
            .doc(widget.docId)
            .update({
          'nombre': _nameController.text,
        });
      }
      Navigator.pop(context, 'saved');
    }
  }

  Future<void> _deleteData() async {
    if (widget.docId != null) {
      await FirebaseFirestore.instance
          .collection('consultorios')
          .doc(widget.docId)
          .delete();
      Navigator.pop(context, 'deleted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Consultorio'),
        actions: [
          if (widget.docId != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _deleteData,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveData,
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
