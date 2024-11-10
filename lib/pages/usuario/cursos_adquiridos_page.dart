import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_cursos_front/services/courses_service.dart';
import 'package:sistema_cursos_front/widgets/card_curso.dart';
import 'package:sistema_cursos_front/widgets/no_courses.dart';
// import '../widgets/card_curso.dart';

//-----   Esta es la view de Favoritos  -----//

class CursosAdquiridosPage extends StatelessWidget {
  const CursosAdquiridosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final courseService = Provider.of<CoursesService>(context);

    return Scaffold(
        body: courseService.courses.isNotEmpty
            ? Column(
                children: [
                  const SizedBox(height: 40),
                  const Center(child: Text("Mis Favoritos")),
                  Expanded(
                    child: ListView.builder(
                      itemCount: courseService.courses.length,
                      itemBuilder: (context, index) {
                        final course = courseService.courses[index];
                        return CardCurso(
                          course: course,
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
                  ),
                ],
              )
            : const NoCourses(
                description: 'No tienes cursos agregados a favoritos',
              ));
  }
}
