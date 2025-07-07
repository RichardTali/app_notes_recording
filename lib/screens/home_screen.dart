import 'package:app_notes/models/note.dart';
import 'package:app_notes/screens/form_note_screen.dart';
import 'package:app_notes/services/database_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Nota> notas = [];


  @override
  void initState(){
    super.initState();
    cargarNotas();
  }

  Future<void> cargarNotas() async{
    final data = await DatabaseService().obtenerNotas();
    setState((){
      notas = data;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notas')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar notas',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: notas.isEmpty
                  ? Center(child: Text('No hay notas'))
                  : GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.75,
                      children: notas.map((nota) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.note, color: Colors.blue),
                                const SizedBox(height: 8),
                                Text(
                                  nota.titulo,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      nota.contenido,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Creado: ${nota.fechaCreacion}',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final resultado = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => FormNoteScreen()),
          );

          if(resultado == true){
            cargarNotas();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}