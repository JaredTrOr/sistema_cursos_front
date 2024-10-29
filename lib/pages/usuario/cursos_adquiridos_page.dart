import 'package:flutter/material.dart';
import '../widgets/card_curso.dart'; 

//-----   Esta es la view de Favoritos  -----//

List<Map<String, dynamic>> cursosAdquiridos = []; 

class CursosAdquiridosPage extends StatelessWidget {
  const CursosAdquiridosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color(0xFF0B6477),
      ),
      body: Column(
        children: [
            Center(child: Text("Mis Favoritos")),
            ListView.builder(
            itemCount: cursosAdquiridos.length,
            itemBuilder: (context, index) {
              final curso = cursosAdquiridos[index];
              return CardCurso(
                title: curso['title']!,
                subtitle: curso['subtitle']!,
                image: curso['image']!,
                price: curso['price']!,
                onTap: () {
                  // Aquí puedes agregar lógica para mostrar detalles del curso
                },
                onFavorite: () {
                  // Aquí podrías implementar la lógica para eliminar de favoritos si lo deseas
                },
                isFavorite: true, // Siempre será verdadero ya que está en la lista de adquiridos
              );
            },
          ),
        ]
      ),
    );
  }
}
