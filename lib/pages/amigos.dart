import 'package:flutter/material.dart';
import 'package:gudpets/services/services.dart';
import 'package:gudpets/shared/shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Amigos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Controller controlador1 = Provider.of<Controller>(context);
    return Scaffold(
      floatingActionButton: StreamBuilder(
          stream: Firestore.instance
              .collection('usuarios')
              .where('solicitudesAE',
                  arrayContains: controlador1.usuario.documentId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            List<DocumentSnapshot> documents = snapshot.data.documents;
            return FloatingActionButton(
              heroTag: 'btnAA1',
              child: documents.isEmpty
                  ? Icon(
                      Icons.person_add,
                      size: 30,
                       color: Colors.white,
                    )
                  : Stack(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.add_alert,
                            size: 30,
                            color: Colors.white,
                          ),
                          width: 30,
                          height: 30,
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.yellow),
                        )
                      ],
                    ),
              onPressed: () {
                showDialog(
                  context: context,
                  child: SolicitudesAmistad(
                    documents: snapshot.data.documents,
                  ),
                );
              },
            );
          }),
      appBar: AppBar(
        title: Text('Amigos'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Text(
              //   'Amigos',
              //   style: TextStyle(fontSize: 23),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              StreamBuilder(
                stream: Firestore.instance
                    .collection('usuarios')
                    .where('amigos',
                        arrayContains: controlador1.usuario.documentId)
                    .orderBy('nombre')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: Container(
                          height: 50, child: const CircularProgressIndicator()),
                    );
                  List<DocumentSnapshot> documents = snapshot.data.documents;
                  print(documents.length);
                  return documents.isEmpty
                      ? Text(
                          'No tienes amigos :C , Haz click en el botón de abajo para buscar mas amigos')
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            UsuarioModel usuario =
                                UsuarioModel.fromDocumentSnapshot(
                                    documents[index]);
                            return AmigoTile(usuario: usuario);
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SolicitudesAmistad extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  SolicitudesAmistad({this.documents});
  @override
  _SolicitudesAmistadState createState() => _SolicitudesAmistadState();
}

class _SolicitudesAmistadState extends State<SolicitudesAmistad> {
  @override
  Widget build(BuildContext context) {
    Controller controller = Provider.of<Controller>(context);
    return WillPopScope(
      onWillPop: () async {
        return !controller.loading;
      },
      child: Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Solicitudes de Amistad',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              widget.documents.isEmpty
                  ? Text(
                      'No tienes solicitudes',
                      style: TextStyle(color: Colors.black),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.documents.length,
                      itemBuilder: (context, index) {
                        UsuarioModel usuario =
                            UsuarioModel.fromDocumentSnapshot(
                                widget.documents[index]);
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(usuario.foto),
                          ),
                          title: Text(usuario.nombre,
                              style: TextStyle(color: Colors.black)),
                          trailing: controller.loading
                              ? CircularProgressIndicator()
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () async {
                                        controller.loading = true;
                                        controller.notify();
                                        await controller.usuario.reference
                                            .updateData({
                                          'amigos': FieldValue.arrayUnion(
                                              [usuario.documentId])
                                        });
                                        await usuario.reference.updateData({
                                          'solicitudesAE':
                                              FieldValue.arrayRemove([
                                            controller.usuario.documentId
                                          ]),
                                          'amigos': FieldValue.arrayUnion(
                                              [controller.usuario.documentId])
                                        });
                                        controller.usuario.amigos
                                            .add(usuario.documentId);
                                        controller.usuario.solicitudesAE
                                            .remove(usuario.documentId);
                                        controller.loading = false;
                                        controller.notify();
                                        Navigator.of(context).pop();
                                      },
                                      icon: Icon(
                                        Icons.check,
                                        color: secondaryDark,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        controller.loading = true;
                                        controller.notify();
                                        await usuario.reference.updateData({
                                          'solicitudesAE':
                                              FieldValue.arrayRemove([
                                            controller.usuario.documentId
                                          ])
                                        });
                                        controller.loading = false;
                                        controller.notify();
                                        Navigator.of(context).pop();
                                      },
                                      icon: Icon(
                                        Icons.delete_forever,
                                        color: secondaryDark,
                                      ),
                                    )
                                  ],
                                ),
                        );
                      },
                    ),
              SizedBox(
                height: 20,
              ),
              FloatingActionButton.extended(
                heroTag: 'btnA1',
                elevation: 0,
                shape: BeveledRectangleBorder(),
                onPressed: () => {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate('usuarios'),
                  )
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 17,
                ),
                label: Text('Buscar Amigos',style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
