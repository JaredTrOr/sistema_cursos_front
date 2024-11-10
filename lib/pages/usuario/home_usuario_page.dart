import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_cursos_front/services/courses_service.dart';
import 'package:sistema_cursos_front/widgets/is_loading.dart';
import 'package:sistema_cursos_front/widgets/no_courses.dart';
import 'package:sistema_cursos_front/widgets/card_curso.dart';

class HomeUsuarioPage extends StatelessWidget {
  const HomeUsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final courseService = Provider.of<CoursesService>(context);

    if (courseService.isLoading) {
      return const IsLoading();
    }    

    return Scaffold(
      body: Expanded(
        child: courseService.courses.isNotEmpty ? 
        ListView.builder(
          itemCount: courseService.courses.length,
          itemBuilder: (context, index) {
            final course = courseService.courses[index];
            return CardCurso(
              course: course,
              onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => CursoPage(course: course),
                        //   ),
                        // );
              },
              onFavorite: () {
                // Handle favorite action
              },
              isFavorite: false, // Set default favorite state
            );
          },
        )
        : const NoCourses(description: 'No hay cursos disponibles',),
      ),
    );
  }
}
