import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Medicamento extends StatefulWidget {
  final String? docId;
  final String? initialCode;
  final String? initialDescription;
  final String? initialStock;
  final DateTime? initialDate;

  const Medicamento(
      {Key? key,
      this.docId,
      this.initialCode,
      this.initialDescription,
      this.initialStock,
      this.initialDate})
      : super(key: key);

  @override
  State<Medicamento> createState() => _MedicamentoState();
}

class _MedicamentoState extends State<Medicamento> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _stockController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialCode != null) {
      _codeController.text = widget.initialCode!;
    }
    if (widget.initialDescription != null) {
      _descriptionController.text = widget.initialDescription!;
    }
    if (widget.initialStock != null) {
      _stockController.text = widget.initialStock!;
    }
    if (widget.initialDate != null) {
      _dateController.text =
          DateFormat('yyyy-MM-dd').format(widget.initialDate!);
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _descriptionController.dispose();
    _stockController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != widget.initialDate)
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
  }

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      if (widget.docId == null) {
        // Crear
        await FirebaseFirestore.instance.collection('medicamentos').add({
          'codigo': _codeController.text,
          'descripcion': _descriptionController.text,
          'disponibilidad': _stockController.text,
          'fecha': _dateController.text,
        });
      } else {
        // Actualizar
        await FirebaseFirestore.instance
            .collection('medicamentos')
            .doc(widget.docId)
            .update({
          'codigo': _codeController.text,
          'descripcion': _descriptionController.text,
          'disponibilidad': _stockController.text,
          'fecha': _dateController.text,
        });
      }
      Navigator.pop(context, 'saved');
    }
  }

  Future<void> _deleteData() async {
    if (widget.docId != null) {
      await FirebaseFirestore.instance
          .collection('medicamentos')
          .doc(widget.docId)
          .delete();
      Navigator.pop(context, 'deleted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Medicamento'),
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
                controller: _codeController,
                decoration: InputDecoration(labelText: 'Código'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el código';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la descripción';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stockController,
                decoration: InputDecoration(labelText: 'Disponibilidad'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la disponibilidad';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Fecha'),
                readOnly: true, // Hace que el campo de texto no sea editable
                onTap: () =>
                    _selectDate(context), // Abre el DatePicker al hacer clic
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la fecha';
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
