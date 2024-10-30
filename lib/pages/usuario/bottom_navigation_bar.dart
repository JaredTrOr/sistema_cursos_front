import 'package:flutter/material.dart';
import 'package:sistema_cursos_front/pages/usuario/carrito_compras_page.dart';
import 'package:sistema_cursos_front/pages/usuario/cursos_adquiridos_page.dart';
import 'package:sistema_cursos_front/pages/usuario/cursos_favoritos_page.dart';
import 'package:sistema_cursos_front/pages/usuario/home_usuario_page.dart';
import 'package:sistema_cursos_front/widgets/perfil_appbar.dart';

class BarraNavegacion extends StatefulWidget {
  const BarraNavegacion({super.key});

  @override
  State<BarraNavegacion> createState() => _BarraNavegacionState();
}

class _BarraNavegacionState extends State<BarraNavegacion> {
  int _paginaActual = 2; 
  List<Widget> _paginas = [
    CursosAdquiridosPage(),
    CursosFavoritosPage(),
    HomeUsuarioPage(),
    CarritoComprasPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPerfil(arrow: false),
      body: _paginas[_paginaActual],
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: Color(0xFF14919B)),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 2) {
            // Si se selecciona "Home", refresca la página
            setState(() {
              _paginaActual = index;
            });
          } else if (index != _paginaActual) {
            // Cambia de página si es diferente
            setState(() {
              _paginaActual = index;
            });
          }
        },
        currentIndex: _paginaActual,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.archive_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: ''),
        ],
      ),
    );
  }
}


