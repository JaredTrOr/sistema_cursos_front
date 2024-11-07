import 'package:flutter/material.dart';
import 'package:sistema_cursos_front/pages/usuario/perfil_usuario_page.dart';

class AppBarPerfil extends StatelessWidget implements PreferredSizeWidget {
  final bool arrow;

  const AppBarPerfil({super.key, required this.arrow});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
          GestureDetector(
            onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PerfilUsuarioPage(),
                    ),
                  );
                },
            child: Row(
              children: [
                Icon(
                  size: 30,
                  Icons.account_circle,
                ),
                const SizedBox(width: 8), 
                const Text("Usuario"),
              ],
            ),
          ),
          // Flecha a la derecha
          arrow
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context); // Regresar a la página anterior
                  },
                  icon: const Icon(Icons.arrow_back),
                )
              : Container(), // Espacio vacío si arrow es falso
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}