class Nota{

  int? id;
  String titulo;
  String contenido;
  String fechaCreacion;
  String? rutaAudio;

  Nota({
    this.id,
    required this.titulo,
    required this.contenido,
    required this.fechaCreacion,
    this.rutaAudio,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'contenido': contenido,
      'fechaCreacion': fechaCreacion,
      'rutaAudio': rutaAudio,
    };
  }

   factory Nota.fromMap(Map<String, dynamic> map) {
    return Nota(
      id: map['id'],
      titulo: map['titulo'],
      contenido: map['contenido'],
      fechaCreacion: map['fechaCreacion'],
      rutaAudio: map['rutaAudio'],
    );
  }

}