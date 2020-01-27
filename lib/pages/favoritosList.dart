import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:adoption_app/services/services.dart';
import 'package:adoption_app/pages/pages.dart';
import 'package:adoption_app/shared/shared.dart';

class FavoritosList extends StatefulWidget {
  @override
  _FavoritosListState createState() => _FavoritosListState();
}

class _FavoritosListState extends State<FavoritosList> {
  @override
  Widget build(BuildContext context) {
    Controller controlador1 = Provider.of<Controller>(context);

    return Scaffold(
      body: Card(
        margin: EdgeInsets.only(top: 40, left: 15, right: 15, bottom: 15),
        child: Container(
          height: double.maxFinite,
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListTile(
                  trailing: Icon(
                    Icons.favorite,
                    color: Colors.pink,
                  ),
                  leading: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  title: Text(
                    'Tus Favoritos',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                StreamBuilder(
                  stream: controlador1.usuario.reference.get().asStream(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return const CircularProgressIndicator();
                    print(snapshot.data['adopciones']);
                    return ListView(
                      physics:
                          ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                      shrinkWrap: true,
                      children: <Widget>[
                        snapshot.data['adopciones'] != null &&
                                snapshot.data['adopciones'].isNotEmpty
                            ? favoriteTile(
                                titulo: 'Adopciones',
                                iconData: Icons.home,
                                list: snapshot.data['adopciones'],
                                controlador1: controlador1
                              )
                            : Container(),
                        snapshot.data['perdidos'] != null &&
                                snapshot.data['perdidos'].isNotEmpty
                            ? favoriteTile(
                                titulo: 'Perdidos',
                                iconData: FontAwesomeIcons.searchLocation,
                                list: snapshot.data['perdidos'],
                                controlador1: controlador1
                              )
                            : Container(),
                        snapshot.data['rescates'] != null &&
                                snapshot.data['rescates'].isNotEmpty
                            ? favoriteTile(
                                titulo: 'Rescates',
                                iconData: FontAwesomeIcons.handHoldingHeart,
                                list: snapshot.data['rescates'],
                                controlador1: controlador1
                              )
                            : Container(),
                        snapshot.data['emergencias'] != null &&
                                snapshot.data['emergencias'].isNotEmpty
                            ? favoriteTile(
                                titulo: 'Emergencias',
                                iconData: FontAwesomeIcons.ambulance,
                                list: snapshot.data['emergencias'],
                                controlador1: controlador1
                              )
                            : Container()
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget favoriteTile( {String titulo,
  IconData iconData,
   List<dynamic> list, Controller controlador1}){

    return ExpansionTile(
      leading: Icon(iconData),
      title: Text(
        titulo,
        style: TextStyle(fontSize: 30),
      ),
      children: <Widget>[
        ListView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
          itemBuilder: (context, index) => ListTile(
            title: Text(list[index]['titulo']),
            trailing: IconButton(
              onPressed: () async {
                await Firestore.instance
                    .collection(titulo.toLowerCase())
                    .document(list[index]['documentId'])
                    .updateData({
                  'favoritos': FieldValue.arrayRemove([controlador1.usuario.documentId]),
                });
                await controlador1.usuario.reference.updateData(
                  {
                    titulo.toLowerCase(): FieldValue.arrayRemove([list[index]])
                  },
                );
                setState(() {
                  
                });
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.pink,
              ),
            ),
            leading: Hero(
              tag: list[index]['documentId'],
              child: GestureDetector(
                onTap: () async {
                  var query = await Firestore.instance
                      .collection(titulo.toLowerCase())
                      .document(list[index]['documentId'])
                      .get();
                  switch (titulo) {
                    case 'Adopciones':
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Adopcion(
                            objeto: AdopcionModel.fromDocumentSnapshot(query),
                          ),
                        ),
                      );
                      break;
                    case 'Perdidos':
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Perdido(
                            objeto: PerdidoModel.fromDocumentSnapshot(query),
                          ),
                        ),
                      );
                      break;
                    case 'Rescates':
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Rescate(
                            objeto: RescateModel.fromDocumentSnapshot(query),
                          ),
                        ),
                      );
                      break;

                    case 'Emergencias':
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Emergencia(
                            objeto: EmergenciaModel.fromDocumentSnapshot(query),
                            favorito: true,
                          ),
                        ),
                      );
                      break;
                  }
                },
                child: Image(
                  width: 40,
                  height: 40,
                  image: NetworkImage(list[index]['imagen']),
                ),
              ),
            ),
          ),
        )
      ],
    );
}
}



