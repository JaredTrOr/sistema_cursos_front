import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_cursos_front/services/courses_service.dart';
import 'package:sistema_cursos_front/services/user_service.dart';
import 'package:sistema_cursos_front/widgets/card_curso.dart';
import 'package:sistema_cursos_front/widgets/no_courses.dart';

class CursosAdquiridosPage extends StatelessWidget {
  const CursosAdquiridosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final courseService = Provider.of<CoursesService>(context);
    final userService = Provider.of<UserService>(context);

    return Scaffold(
        body: userService.getUserFavoriteCourses.isNotEmpty
            ? Column(
                children: [
                  const SizedBox(height: 20),
                  const Center(child: Text("Mis Favoritos", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: userService.getUserFavoriteCourses.length,
                      itemBuilder: (context, index) {

                        String courseId = userService.getUserFavoriteCourses[index];
                        final course = courseService.getCourseById(courseId);

                        return CardCurso(
                          course: course,
                          onAdd: () {
                            
                          },
                          onTap: () { },
                          onFavorite: () {
                            if (!userService.isFavoriteCourse(course.id!)) {
                              userService.addFavoriteCourse(course.id!);
                              courseService.increaseAmountOfFavorites(course);
                              return;
                            }
                            userService.removeFavoriteCourse(course.id!);
                            courseService.decreaseAmountOfFavorites(course);
                          },
                          
                          isFavorite: userService.isFavoriteCourse(course.id!), 
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
