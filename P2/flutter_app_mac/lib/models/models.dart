

import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart' show rootBundle;

var Filtrado = [
  'selecciona',
  'TIEMPO',
  'PRECIO',
  'MULTITUD'
];


/// Representa la entidad Evento (falta por completar)
class Evento {
  static final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  String _name, _ubicacion;
  double _precio;
  int _publico;
  DateTime _fecha;

  Evento(this._name, this._ubicacion, this._publico);

  Evento.fromJSON(Map<String, dynamic> json) {
    _name = json['nombre'];
    _ubicacion = json['ubicacion'];
    _publico = json['plazas'];
    _precio = json['precio'];
    _fecha = dateFormat.parse(json['fecha']);
  }

  get name => _name;
  get ubi => _ubicacion;
  get publico => _publico;
  get precio => _precio;

  @override
  String toString() => "$_name   ~   $_ubicacion";

  Map<String, dynamic> toJson() =>
      {'nombre': name, 'ubi': this.ubi, "publico": publico};
}

/// Representa al conjunto de eventos a los que ha asistido un usuario.
/// Satisface operaciones estadísticas sobre el conjunto de eventos que se
/// postula como el historial de eventos comprados de un usuario.
class EventosSet {
  List<Evento> _eventos;

  EventosSet() {
    this._eventos = [];
  }

  Future<List<Evento>> cargarDatos() async {
    print('cargand datos...');
    var txt = await rootBundle.loadString('assets/data/eventos.json');
    var json = jsonDecode(txt);
    _eventos = List<Evento>.from(json.map((model)=> Evento.fromJSON(model)));
    return _eventos;
  }

  get eventos => _eventos;

  @override
  String toString() {
    return '{$_eventos}';
  }
}