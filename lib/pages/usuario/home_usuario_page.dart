import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_cursos_front/models/courses_model.dart';
import 'package:sistema_cursos_front/services/courses_service.dart';
import 'package:sistema_cursos_front/widgets/no_courses.dart';
import 'package:sistema_cursos_front/widgets/search_productos.dart';
import 'package:sistema_cursos_front/pages/usuario/curso_page.dart';
import 'package:sistema_cursos_front/widgets/card_curso.dart';
import 'cursos_adquiridos_page.dart'; // Asegúrate de importar la página de cursos adquiridos

class HomeUsuarioPage extends StatelessWidget {
  const HomeUsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final courseService = Provider.of<CoursesService>(context);

    if (courseService.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }    

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: 
          courseService.courses.isNotEmpty ? 
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
      ),
    );
  }
}
