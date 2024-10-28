import 'package:flutter/material.dart';
import 'package:sistema_cursos_front/pages/usuario/curso_page.dart';
import 'package:sistema_cursos_front/pages/usuario/cursos_adquiridos_page.dart';
import 'package:sistema_cursos_front/pages/widgets/card_curso.dart';

class SearchProductos extends SearchDelegate {
  final List<Map<String, String>> cursos;


  SearchProductos({required this.cursos});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Limpia la consulta
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Cierra el buscador
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final resultados = cursos.where((curso) => curso['title']!.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: resultados.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(resultados[index]['title']!),
          subtitle: Text(resultados[index]['subtitle']!),
          onTap: () {
            // Acciones al seleccionar un resultado
            close(context, resultados[index]);
          },
        );
      },
    );
  }

  @override
 @override
Widget buildSuggestions(BuildContext context) {
  final sugerencias = cursos.where((curso) => curso['title']!.toLowerCase().contains(query.toLowerCase())).toList();

  return ListView.builder(
    itemCount: sugerencias.length,
    itemBuilder: (context, index) {
      return CardCurso(
        title: sugerencias[index]['title']!,
        subtitle: sugerencias[index]['subtitle']!,
        image: sugerencias[index]['image']!,
        price: sugerencias[index]['price']!,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CursoPage(
                title: sugerencias[index]['title']!,
                subtitle: sugerencias[index]['subtitle']!,
                image: sugerencias[index]['image']!,
                price: sugerencias[index]['price']!,
              ),
            ),
          );
        },
        onFavorite: () {
          // Agregar el curso a la lista de cursos adquiridos
          if (!cursosAdquiridos.any((c) => c['title'] == sugerencias[index]['title'])) {
            cursosAdquiridos.add(sugerencias[index]);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${sugerencias[index]['title']} agregado a Mis FAvoritos')));
          }
        },
        isFavorite: false, 
      );
    },
  );
}


}
