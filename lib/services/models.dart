import 'package:flutter/material.dart';
import 'package:adoption_app/services/services.dart';

class UsuarioModel {
  String contrasena;
  String correo;
  String descripcion;
  int edad;
  String foto;
  String nombre;
  String sexo;
  int telefono;
  String tipo;
  int user_id;
  String document_id;

  UsuarioModel(
      {this.contrasena,
      this.correo,
      this.descripcion,
      this.edad,
      this.foto,
      this.nombre,
      this.sexo,
      this.telefono,
      this.tipo,
      this.user_id,
      this.document_id});

  UsuarioModel.fromDocumentSnapshot(DocumentSnapshot data) {
    contrasena = data['tcontrasena'];
    correo = data['correo'];
    descripcion = data['descripcion'];
    edad = data['edad'];
    foto = data['foto'];
    nombre = data['nombre'];
    sexo = data['sexo'];
    telefono = data['telefono'];
    tipo = data['tipo'];
    user_id = data['user_id'];
    document_id = data.documentID.toString();
  }
}

class RescateModel {
  String descripcion;
  String ubicacion;
  int telefono;
  int user_id;
  int rescate_id;
  dynamic fotos;
  String tipo_animal;
  String titulo;
  String foto;
  String document_id;

  RescateModel(
      {this.fotos,
      this.rescate_id,
      this.ubicacion,
      this.descripcion,
      this.user_id,
      this.telefono,
      this.tipo_animal,
      this.titulo,
      this.foto,
      this.document_id});

  RescateModel.fromDocumentSnapshot(DocumentSnapshot data) {
    titulo = data['titulo'] ?? '';
    ubicacion = data['ubicacion'];
    descripcion = data['descripcion'];
    user_id = data['user_id'];
    fotos = data['fotos'];
    tipo_animal = data['tipo_animal'];
    rescate_id = data['rescate_id'];
    foto = data['foto'];
    document_id = data.documentID.toString();
  }
}

class EmergenciaModel {
  String titulo;
  String tipo_emergencia;
  String ubicacion;
  String descripcion;
  int user_id;
  int emergencia_id;
  String foto;
  String tipo_animal;
  String document_id;

  EmergenciaModel(
      {this.titulo,
      this.tipo_emergencia,
      this.ubicacion,
      this.descripcion,
      this.user_id,
      this.emergencia_id,
      this.foto,
      this.tipo_animal,
      this.document_id});

  EmergenciaModel.fromDocumentSnapshot(DocumentSnapshot data) {
    titulo = data['titulo'];
    tipo_emergencia = data['tipo_emergencia'];
    ubicacion = data['ubicacion'];
    descripcion = data['descripcion'];
    user_id = data['user_id'];
    foto = data['foto'];
    tipo_animal = data['tipo_animal'];
    emergencia_id = data['emergencia_id'];
    document_id = data.documentID.toString();
  }
}

class PerdidoModel {
  String titulo;
  String perdido_id;
  int user_id;
  String descripcion;
  String tipo_animal;
  String ubicacion;
  String foto;
  bool recompensa;
  String raza;
  String senas_part;
  String sexo;
  DateTime fecha_extravio;
  String document_id;

  PerdidoModel(
      {this.titulo,
      this.user_id,
      this.descripcion,
      this.tipo_animal,
      this.ubicacion,
      this.foto,
      this.recompensa,
      this.raza,
      this.senas_part,
      this.sexo,
      this.fecha_extravio,
      this.document_id,
      this.perdido_id});

  PerdidoModel.fromDocumentSnapshot(DocumentSnapshot data) {
    titulo = data['titulo'];
    user_id = data['user_id'];
    descripcion = data['descripcion'];
    tipo_animal = data['tipo_animal'];
    ubicacion = data['ubicacion'];
    foto = data['foto'];
    recompensa = data['recompensa'];
    raza = data['raza'];
    senas_part = data['senas_part'];
    sexo = data['sexo'];
    fecha_extravio = data['fecha_extravio'];
    perdido_id = data['perdido_id'];
    document_id = data.documentID.toString();
  }
}

class AdopcionModel {
  String document_id;
  String foto;

  AdopcionModel({this.document_id, this.foto});

  AdopcionModel.fromDocumentSnapshot(DocumentSnapshot data) {
    document_id = data.documentID.toString();
    foto = data['foto'];
  }
}