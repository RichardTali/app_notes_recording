import 'package:app_notes/models/note.dart';
import 'package:app_notes/services/database_service.dart';
import 'package:flutter/material.dart';

class FormNoteScreen extends StatefulWidget {
  const FormNoteScreen({super.key});

  @override
  State<FormNoteScreen> createState() => _FormNoteScreenState();
}

class _FormNoteScreenState extends State<FormNoteScreen> {

  final TextEditingController _tituloController = TextEditingController();
final TextEditingController _contenidoController = TextEditingController();


@override
void dispose() {
  _tituloController.dispose();
  _contenidoController.dispose();
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Nota'),
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contenidoController,
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Contenido'),
            ),
            const SizedBox(height: 16),
           ElevatedButton(
              onPressed: () async {
                final titulo = _tituloController.text.trim();
                final contenido = _contenidoController.text.trim();

                if (titulo.isEmpty || contenido.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Por favor, completa todos los campos')),
                  );
                  return;
                }

                final nuevaNota = Nota(
                  titulo: titulo,
                  contenido: contenido,
                  fechaCreacion: DateTime.now().toString(),
                );

                await DatabaseService().insertNote(nuevaNota); // 👈 Aquí guardas la nota

                Navigator.pop(context, true);
              },
              child: const Text('Guardar Nota'),
            ),
          ],
        ),
      ),
    );
  }
}