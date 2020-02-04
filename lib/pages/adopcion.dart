import 'package:flutter/material.dart';
import 'package:adoption_app/pages/pages.dart';
import 'package:adoption_app/services/services.dart';
import 'package:adoption_app/shared/shared.dart';
import 'dart:async';

class Adopcion extends StatefulWidget {
  final AdopcionModel objeto;
  bool favorito;

  Adopcion({this.objeto, this.favorito});

  @override
  _AdopcionState createState() => _AdopcionState();
}

class _AdopcionState extends State<Adopcion> {
  Map<String, dynamic> form_solicitud = {};

  @override
  Widget build(BuildContext context) {
    Controller controlador1 = Provider.of<Controller>(context);
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: Colors.white,
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              FontAwesomeIcons.chevronCircleLeft,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.only(bottom: 20, top: 30, right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  height: 350,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: <Widget>[
                      Hero(
                          tag: widget.objeto.documentId,
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: AssetImage('assets/perriti_pic.png'),
                            width: double.maxFinite,
                            height: 350,
                            image: NetworkImage(widget.objeto.foto),
                          )),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                            ),
                            color: Colors.brown[300]),
                        padding: EdgeInsets.all(10.0),
                        width: widget.objeto.userName.length * 11.5,
                        height: 40,
                        alignment: Alignment.bottomRight,
                        child: Text(
                          widget.objeto.userName,
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 20, top: 10, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                widget.objeto.titulo,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: <Widget>[
                                Text('Tipo:', style: TextStyle(fontSize: 12)),
                                widget.objeto.tipoAnimal == 'perro'
                                    ? Icon(FontAwesomeIcons.dog)
                                    : widget.objeto.tipoAnimal == 'gato'
                                        ? Icon(FontAwesomeIcons.cat)
                                        : widget.objeto.tipoAnimal == 'ave'
                                            ? Icon(FontAwesomeIcons.dove)
                                            : Text(
                                                'otro',
                                                style: TextStyle(fontSize: 15),
                                              ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              icon: Icon(widget.favorito
                                  ? Icons.favorite
                                  : Icons.favorite_border),
                              iconSize: 30.0,
                              color: Colors.pink,
                              onPressed: () {
                                !widget.favorito
                                    ? _favtrue(widget.favorito, controlador1,
                                        widget.objeto)
                                    : _favfalse(widget.favorito, controlador1,
                                        widget.objeto);

                                setState(() {
                                  widget.favorito
                                      ? widget.favorito = false
                                      : widget.favorito = true;
                                });

                                print(widget.favorito.toString());
                              },
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20),
                          child: Text(widget.objeto.descripcion,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey,
                              )),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Fecha de publicación: ',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      )),
                                  Text(
                                    widget.objeto.fecha.day.toString() +
                                        '/' +
                                        widget.objeto.fecha.month.toString() +
                                        '/' +
                                        widget.objeto.fecha.year.toString(),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text('Edad: ',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      )),
                                  Text(widget.objeto.edad,
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.grey)),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text('Convivencia con otros: ',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      )),
                                  Text(
                                      widget.objeto.convivenciaotros
                                          ? 'Sí'
                                          : 'No',
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.grey)),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text('Desparacitado: ',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      )),
                                  Text(
                                      widget.objeto.desparacitacion
                                          ? 'Sí'
                                          : 'No',
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.grey)),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text('Vacunado: ',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      )),
                                  Text(widget.objeto.vacunacion ? 'Sí' : 'No',
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.grey)),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text('Esterilizado: ',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      )),
                                  Text(
                                      widget.objeto.esterilizacion
                                          ? 'Sí'
                                          : 'No',
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.grey)),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text('Sexo:',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      )),
                                  Text(widget.objeto.sexo,
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.grey)),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ButtonBar(
                          children: <Widget>[
                            controlador1.usuario.reference.documentID ==
                                    widget.objeto.userId
                                ? RaisedButton.icon(
                                    icon: Icon(FontAwesomeIcons.userFriends),
                                    label: Text('Solicitudes'),
                                    onPressed: () {
                                      print(widget.objeto.documentId);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SolicitudAdopcion(
                                                  docId:
                                                      widget.objeto.reference,
                                                )),
                                      );
                                    },
                                  )
                                : RaisedButton.icon(
                                    icon: Icon(FontAwesomeIcons.home),
                                    label: Text('Adoptar'),
                                    onPressed: () async {
                                      print('boton adoptar');
                                      var query = Firestore.instance
                                          .collectionGroup('solicitudes')
                                          .where('userId',
                                              isEqualTo: controlador1
                                                  .usuario.documentId)
                                          .getDocuments();
                                      query.then((onValue) {
                                        print('query');
                                        if (onValue.documents.isNotEmpty) {
                                          return showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                    title: Text(
                                                        'Solicitud realizada '),
                                                    content: Text(
                                                        'Ya te encuentras postulado'),
                                                    actions: <Widget>[
                                                      RaisedButton(
                                                        onPressed: () {
                                                          return Navigator.of(
                                                                  context)
                                                              .pop();
                                                        },
                                                        child: Text('Cerrar'),
                                                      )
                                                    ],
                                                  ));
                                        } else {
                                          print('boton para adoptar');
                                          if (controlador1.usuario.fotoStorageRef == null &&
                                              controlador1.usuario
                                                      .fotoCompDomiRef ==
                                                  null &&
                                              controlador1.usuario.fotoINERef ==
                                                  null &&
                                              controlador1
                                                      .usuario.fotosHogarRefs ==
                                                  null) {
                                            showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                      title: Text(
                                                          'No puedes postularte'),
                                                      content: Text(
                                                          'Para postularte es necesario completar tu información.'),
                                                      actions: <Widget>[
                                                        RaisedButton(
                                                          onPressed: () {
                                                            return Navigator.of(
                                                                    context)
                                                                .pushNamed(
                                                                    '/perfil');
                                                          },
                                                          child: Text(
                                                              'Ir a perfil'),
                                                        )
                                                      ],
                                                    ));
                                          } else {
                                            print('solicitud valida');
                                            form_solicitud['correo'] =
                                                controlador1.usuario.correo;
                                            form_solicitud['descripcion'] =
                                                controlador1.usuario.descripcion;
                                            form_solicitud['fnacimiento'] =
                                                controlador1.usuario.fnacimiento;
                                            form_solicitud['foto'] =
                                                controlador1.usuario.foto;
                                            form_solicitud['nombre'] =
                                                controlador1.usuario.nombre;
                                            form_solicitud['sexo'] =
                                                controlador1.usuario.sexo;
                                            form_solicitud['telefono'] =
                                                controlador1.usuario.telefono;
                                            form_solicitud['documentId'] =
                                                controlador1.usuario.documentId;
                                            form_solicitud['referencia'] =
                                                controlador1.usuario.reference;
                                            form_solicitud['fotoStorageRef'] =
                                                controlador1.usuario.fotoStorageRef;
                                            form_solicitud['fotoCompDomi'] =
                                                controlador1.usuario.fotoCompDomi;
                                            form_solicitud['fotoCompDomiRef'] =
                                                controlador1.usuario.fotoCompDomiRef;
                                            form_solicitud['fotoINE'] =
                                                controlador1.usuario.fotoINE;
                                            form_solicitud['fotoINERef'] =
                                                controlador1.usuario.fotoINERef;
                                            form_solicitud['galeriaFotos'] =
                                                controlador1.usuario.galeriaFotos;
                                            form_solicitud['galeriaFotosRefs'] =
                                                controlador1.usuario.galeriaFotosRefs;
                                            
                                            var agregar = widget
                                                .objeto.reference
                                                .collection('solicitudes')
                                                .add(form_solicitud)
                                                .then((value) {
                                              if (value != null) {
                                                return true;
                                              } else {
                                                return false;
                                              }
                                            });
                                            if (agregar != null) {
                                              Navigator.of(context).pop();
                                            }
                                          }
                                        }
                                      });
                                    }),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }

  _favtrue(bool favorito, Controller controlador1, AdopcionModel objeto) {
    objeto.reference.updateData({
      'favoritos': FieldValue.arrayUnion([controlador1.usuario.documentId]),
    });
    controlador1.usuario.reference.updateData(
      {
        'adopciones': FieldValue.arrayUnion([
          {
            'imagen': objeto.foto,
            'titulo': objeto.titulo,
            'documentId': objeto.documentId,
          }
        ])
      },
    );
  }

  _favfalse(bool favorito, Controller controlador1, AdopcionModel objeto) {
    objeto.reference.updateData({
      'favoritos': FieldValue.arrayRemove([controlador1.usuario.documentId])
    });
    controlador1.usuario.reference.updateData(
      {
        'adopciones': FieldValue.arrayRemove([
          {
            'imagen': objeto.foto,
            'titulo': objeto.titulo,
            'documentId': objeto.documentId,
          }
        ])
      },
    );
  }
}
