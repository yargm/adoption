import 'package:gudpets/pages/fotos.dart';
import 'package:gudpets/pages/mapaejemplo.dart';
import 'package:gudpets/pages/registroAdopcion.dart';
import 'package:flutter/material.dart';
import 'package:gudpets/pages/pages.dart';
import 'package:gudpets/services/services.dart';
import 'package:gudpets/shared/shared.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

Controller controller = Controller();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => controller,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryTextTheme: GoogleFonts.josefinSansTextTheme(),
          scaffoldBackgroundColor: primaryColor,
          primaryColor: secondaryLight,
          accentColor: primaryDark,
          disabledColor: primaryDark,
          primaryColorDark: primaryDark,
          primaryColorLight: primaryLight,

          highlightColor: secondaryColor,
          indicatorColor: secondaryColor,
          focusColor: secondaryColor,
          hintColor: secondaryColor,
          // inputDecorationTheme: InputDecorationTheme(
          //     labelStyle: TextStyle(color: secondaryColor),
          //     focusColor: secondaryColor,
          //     focusedBorder: OutlineInputBorder(
          //         borderSide: BorderSide(
          //           color: secondaryColor,
          //         ),
          //         borderRadius: BorderRadius.circular(15)),
          //     border:
          //         OutlineInputBorder(borderRadius: BorderRadius.circular(15))),

          //botones
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
            disabledColor: primaryDark,
            buttonColor: secondaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          ),
          //navbar
          bottomAppBarTheme: BottomAppBarTheme(
            color: primaryLight,
          ),
          //iconos

          iconTheme: IconThemeData(
            size: 25,
            color: secondaryColor,
          ),
          primaryIconTheme: IconThemeData(
            color: secondaryColor,
          ),
          //texto
          textTheme: GoogleFonts.josefinSansTextTheme(TextTheme(
            bodyText2: TextStyle(fontSize: 15),
            button: TextStyle(fontSize: 15, color: Colors.white),
            bodyText1: TextStyle(fontSize: 18),
          )),
          //flotante
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: secondaryColor),

          //appbar
          appBarTheme: AppBarTheme(
              elevation: 0,
              iconTheme: IconThemeData(size: 30, color: secondaryDark),
              actionsIconTheme: IconThemeData(color: secondaryDark, size: 30),
              textTheme: GoogleFonts.josefinSansTextTheme(TextTheme(
                  headline6: TextStyle(color: primaryText, fontSize: 20))),
              color: primaryDark),
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        // home: Home(
        //   controlador1: controller,
        // ),
        routes: {
          '/login': (BuildContext context) => LogIn(),
          '/registro_usuario': (BuildContext context) => RegistroUsuario(),
          '/home': (BuildContext context) => Home(
                controlador1: controller,
              ),
          '/adopcion': (BuildContext context) => Adopcion(),
          '/perdido': (BuildContext context) => Perdido(),
          '/emergencia': (BuildContext context) => Emergencia(),
          '/registro_emergencia': (BuildContext context) =>
              RegistroEmergencia(),
          '/registro_adopcion': (BuildContext context) => RegistroAdopcion(),
          '/registro_perdido': (BuildContext context) => RegistroPerdido(),
          '/mapaejemplo': (BuildContext context) => MapSample(),
          '/avisos': (BuildContext context) => AvisosList(),
          '/publicaciones': (BuildContext context) => PublicacionList(),
          '/perfil': (BuildContext context) => Perfil(
                usuario: controller.usuario,
              ),
          '/favoritos': (BuildContext context) => FavoritosList(),
          '/info': (BuildContext context) => Info(),
          '/adoptadosList': (BuildContext context) => AdoptadosList(),
          '/registroMascota': (BuildContext context) => RegistroMascota(),
          '/mascotaDetails': (BuildContext context) => MascotaDetails(),
          '/fotosPrincipal': (BuildContext context) => FotosPrincipal(),
          '/amigos': (BuildContext context) => Amigos(),
          '/Filtros': (BuildContext context) => FiltrosdeFotos(),
        },
      ),
    );
  }
}
