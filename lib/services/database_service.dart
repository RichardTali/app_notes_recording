import 'package:app_notes/models/note.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService{
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Database? _db;

  Future<Database> get database async{
    if(_db !=null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB()async{
    final directory = await getApplicationCacheDirectory();
    final path = join(directory.path, 'notes.db');
     return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async{
    await db.execute('''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        contenido TEXT NOT NULL,
        fechaCreacion TEXT NOT NULL,
        rutaAudio TEXT
      )
    ''');
  }

  //INSERTAR
  Future<int> insertNote(Nota nota) async{
    final db = await database;
    return await db.insert('notas', nota.toMap());
  }

}