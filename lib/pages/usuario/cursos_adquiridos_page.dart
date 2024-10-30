import 'package:flutter/material.dart';
import 'package:sistema_cursos_front/widgets/card_curso.dart';
// import '../widgets/card_curso.dart';

//-----   Esta es la view de Favoritos  -----//

List<Map<String, dynamic>> cursosAdquiridos = [
  {
    'title': 'Curso de Flutter',
    'subtitle': 'Aprende a programar apps con Flutter',
    'image':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT7HZFCI0Euwzq8qotUFeCbHhhISYdqUt4rg&s',
    'price': "100",
  },
  {
    'title': 'Curso de Dart',
    'subtitle': 'Aprende a programar con Dart',
    'image':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT7HZFCI0Euwzq8qotUFeCbHhhISYdqUt4rg&s',
    'price': "50",
  },
];

class CursosAdquiridosPage extends StatelessWidget {
  const CursosAdquiridosPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 40,
        ),
        Center(child: Text("Mis Favoritos")),
        cursosAdquiridos.isNotEmpty ?
        Expanded(
          child: ListView.builder(
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
                isFavorite:
                    true, // Siempre será verdadero ya que está en la lista de adquiridos
              );
            },
          ),
        ) : Container(),
      ]),
    );
  }
}
