import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_cursos_front/models/courses_model.dart';
import 'package:sistema_cursos_front/pages/usuario/curso_page.dart';
import 'package:sistema_cursos_front/services/courses_service.dart';
import 'package:sistema_cursos_front/services/user_service.dart';
import 'package:sistema_cursos_front/widgets/is_loading.dart';
import 'package:sistema_cursos_front/widgets/no_courses.dart';
import 'package:sistema_cursos_front/widgets/perfil_appbar.dart';
import 'package:sistema_cursos_front/widgets/pop_up.dart';
import 'package:sistema_cursos_front/widgets/pop_up_confirmation.dart';

class CursosCreadorContenidoPage extends StatelessWidget {
  const CursosCreadorContenidoPage({super.key});

  @override
  Widget build(BuildContext context) {

    final userService = Provider.of<UserService>(context);

    return ChangeNotifierProvider(
      create: (context) => CoursesService(authorId: userService.userProvider.id),
      child: const CursoCreadoContenidoBody(),
    );
  }
}

class CursoCreadoContenidoBody extends StatelessWidget {
  const CursoCreadoContenidoBody({super.key});

  @override
  Widget build(BuildContext context) {
  final courseService = Provider.of<CoursesService>(context);
  final userService = Provider.of<UserService>(context);

    return Scaffold(
      appBar: const AppBarPerfil(arrow: false),
      body: Column(
        children: [
          const SizedBox(height: 40),

          courseService.isLoading 
          ? const IsLoading() : 
          courseService.courses.isEmpty ? const Expanded(child: NoCourses(description: 'No has creado ningún curso aún')) :
          Expanded(
            child: ListView.builder(
              itemCount: courseService.courses.length,
              itemBuilder: (context, index) {
                final course = courseService.courses[index];
                return _CourseCard(
                  context,
                  courseService,
                  course
                );
              },
            ),
          ),
          const SizedBox(height: 50),
          // Botón para agregar curso
          GestureDetector(
            onTap: () {

              final newCourse = Course(
                name: '', 
                description: '', 
                price: 0, 
                timeDuration: '', 
                author: userService.userProvider.name,
                authorId: userService.userProvider.id, 
                language: '',
                lessons: [],
              );

              courseService.selectedCourse = newCourse;

              Navigator.pushNamed(
              context,
              'agregar_curso',
              arguments: [courseService, newCourse],
              );

            },
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  color: Color(0xFF14919B),
                  style: BorderStyle.solid,
                  width: 1.5,
                ),
              ),
              elevation: 0,
              child: Container(
                width: 300,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF14919B),
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 60),
                    Icon(Icons.add_circle_outline_rounded, color: Color(0xFF14919B), size: 35),
                    SizedBox(width: 15),
                    Text(
                      "Agregar Curso",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF14919B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _CourseCard(BuildContext context, CoursesService courseService, Course course) {
    return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CursoPage(
                          course: course,
                          permission: true,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 10,
                    color: const Color(0xFF213A57),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 90,
                                width: 90,
                                child: course.image == null || course.image == ''
                                    ? const Image(
                                        image: AssetImage('assets/no-image.png'),
                                        fit: BoxFit.cover,
                                      )
                                    : FadeInImage(
                                        placeholder: const AssetImage('assets/jar-loading.gif'),
                                        image: NetworkImage(course.image!),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              const SizedBox(width: 16),
                              // Wrap the Column with Expanded or Flexible
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      course.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      course.description,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    Text(
                                      course.author,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  courseService.selectedCourse = course;
                                  Navigator.pushNamed(
                                    context,
                                    'agregar_curso',
                                    arguments: [courseService, course],
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(const Color(0xFF80ED99)),
                                ),
                                child: const Text(
                                  'Editar',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  popUpConfirmation(context: context, title: 'Eliminación de curso', body: const Text('¿Estás seguro de querer eliminar el curso?'), onAccept: () {
                                    courseService.deleteCourse(course.id!)
                                    .then((response) {

                                      // if (response['success']) {
                                      //   popUp(context: context, title: 'Curso eliminado', body: 'El curso ha sido eliminado exitosamente', dialogType: 'success');
                                      // } else {
                                      //   popUp(context: context, title: 'error', body: response['message'], dialogType: 'error');
                                      // }
                                    }).catchError((error) {
                                      popUp(context: context, title: 'error', body: 'Hubo un error al borrar el curso', dialogType: 'error');
                                    });
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(const Color(0xFF80ED99)),
                                ),
                                child: const Text(
                                  'Eliminar',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
  }
}
