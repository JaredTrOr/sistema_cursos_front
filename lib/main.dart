import 'package:flutter/material.dart';
import 'package:sistema_cursos_front/pages/login_page.dart';
import 'package:sistema_cursos_front/pages/registro_page.dart';
import 'package:sistema_cursos_front/pages/usuario/bottom_navigation_bar.dart';
import 'package:sistema_cursos_front/pages/usuario/carrito_compras_page.dart';
import 'package:sistema_cursos_front/pages/usuario/cursos_adquiridos_page.dart';
import 'package:sistema_cursos_front/pages/usuario/cursos_favoritos_page.dart';
import 'package:sistema_cursos_front/pages/usuario/home_usuario_page.dart';
import 'package:sistema_cursos_front/pages/usuario/metodo_pago_page.dart';
import 'package:sistema_cursos_front/pages/usuario/perfil_usuario_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plataforma de cursos',
      initialRoute: 'navigation',
      theme: ThemeData.light(),
      routes: {
        'login': (context) => const LoginPage(),
        'registro': (context) => const RegistroPage(),

        //USUARIO
        'home_usuario': (context) => const HomeUsuarioPage(),
        'navigation': (context) => const BarraNavegacion(),
        'cursos_adquiridos': (context) => const CursosAdquiridosPage(),
        'curso_favoritos':(context)=> const CursosFavoritosPage(),
        'carrito_compras': (context) => const CarritoComprasPage(),
        'metodo_pago': (context) => const MetodoPagoPage(),
        'perfil_usuario': (context) => const PerfilUsuarioPage(),
      },
    );
  }
}