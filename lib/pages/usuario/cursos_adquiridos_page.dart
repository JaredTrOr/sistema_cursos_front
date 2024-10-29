import 'package:flutter/material.dart';
import '../widgets/card_curso.dart';

//-----   Esta es la view de Favoritos  -----//

List<Map<String, dynamic>> cursosAdquiridos = [];

class CursosAdquiridosPage extends StatelessWidget {
  const CursosAdquiridosPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('WATAFAK NGGA');
    print(cursosAdquiridos);

    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 40,
        ),
        Center(child: Text("Mis Favoritos")),
        // cursosAdquiridos.isNotEmpty ?
        // ListView.builder(
        //   itemCount: cursosAdquiridos.length,
        //   itemBuilder: (context, index) {
        //     final curso = cursosAdquiridos[index];
        //     return CardCurso(
        //       title: curso['title']!,
        //       subtitle: curso['subtitle']!,
        //       image: curso['image']!,
        //       price: curso['price']!,
        //       onTap: () {
        //         // Aquí puedes agregar lógica para mostrar detalles del curso
        //       },
        //       onFavorite: () {
        //         // Aquí podrías implementar la lógica para eliminar de favoritos si lo deseas
        //       },
        //       isFavorite:
        //           true, // Siempre será verdadero ya que está en la lista de adquiridos
        //     );
        //   },
        // ) : Container(),
      ]),
    );
  }
}
