const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

exports.nuevaEmergencia = functions.firestore.document('/emergencias/{emergencia}'
).onCreate((snapshot, context) => {
    var emergenciaData = snapshot.data();
    var listaTokens = [];

    admin.firestore().collection('usuarios').get().then((snapshot) => {
        var listaUsuarios = snapshot.docs;
        for (var usuario of listaUsuarios) {
            if (usuario.data().tokens != undefined) {
                console.log('tokens definido');
                if (usuario.data().tokens != null) {
                    console.log('tokens no nulo');
                    for (var token of usuario.data().tokens) {
                        console.log('adding token');
                        listaTokens.push(token);
                    }
                }
            }

        }
        var payload = {
            "notification": {
                "title": "Nueva Emergencia!!!",
                "body": emergenciaData.titulo,
                "sound": "default"
            },
            "data": {
                "sendername": emergenciaData.titulo,
                "message": 'idk',
            }
        }

        return admin.messaging().sendToDevice(listaTokens, payload).then((response) => {
            console.log('Se enviaron todas las notificaciones');

        }).catch((err) => {
            console.log(err);
        });
    })
})

exports.nuevoPerdido = functions.firestore.document('/perdidos/{perdido}'
).onCreate((snapshot, context) => {
    var perdidoData = snapshot.data();
    var listaTokens = [];

    admin.firestore().collection('usuarios').get().then((snapshot) => {
        var listaUsuarios = snapshot.docs;
        for (var usuario of listaUsuarios) {
            if (usuario.data().tokens != undefined) {
                console.log('tokens definido');
                if (usuario.data().tokens != null) {
                    console.log('tokens no nulo');
                    for (var token of usuario.data().tokens) {
                        console.log('adding token');
                        listaTokens.push(token);
                    }
                }
            }

        }
        var payload = {
            "notification": {
                "title": "Nueva Emergencia!!!",
                "body": perdidoData.titulo,
                "sound": "default"
            },
            "data": {
                "sendername": perdidoData.titulo,
                "message": 'idk',
            }
        }

        return admin.messaging().sendToDevice(listaTokens, payload).then((response) => {
            console.log('Se enviaron todas las notificaciones');

        }).catch((err) => {
            console.log(err);
        });
    })
})

exports.emergenciaEliminada = functions.firestore.document('/emergencias/{emergencia}'
).onDelete((snapshot, context) => {
    var emergenciaData = snapshot.data();
    var emergenciaID = snapshot.id;

    admin.firestore().collection('usuarios').get().then((snapshot) => {
        var listaUsuarios = snapshot.docs;
        for (var usuario of listaUsuarios) {
            if (usuario.data().emergencias != undefined) {
                if (usuario.data().emergencias != null) {
                    for (var adopcion of usuario.data().emergencias) {
                        var documentID = adopcion['documentId'];
                        console.log(adopcion['documentId']);
                        if (documentID == emergenciaID) {
                            usuario.ref.update({ emergencias : admin.firestore.FieldValue.arrayRemove(adopcion)}
                            ).then(() => {
                                console.log('deleted from ' + usuario.data().correo)
                            });
                        }
                    }
                }
            }
        }
        console.log('deleted all the registers')
    })
})

exports.perdidoEliminado = functions.firestore.document('/perdidos/{perdido}'
).onDelete((snapshot, context) => {
    
    var perdidoID = snapshot.id;

    admin.firestore().collection('usuarios').get().then((snapshot) => {
        var listaUsuarios = snapshot.docs;
        for (var usuario of listaUsuarios) {
            if (usuario.data().perdidos != undefined) {
                if (usuario.data().perdidos != null) {
                    for (var perdido of usuario.data().perdidos) {
                        var documentID = perdido['documentId'];
                        console.log(adopcion['documentId']);
                        if (documentID == perdidoID) {
                            usuario.ref.update({ perdidos : admin.firestore.FieldValue.arrayRemove(perdido)}
                            ).then(() => {
                                console.log('deleted from ' + usuario.data().correo)
                            });

                        }
                    }
                }
            }

        }
        console.log('deleted all the registers')
    })

})
