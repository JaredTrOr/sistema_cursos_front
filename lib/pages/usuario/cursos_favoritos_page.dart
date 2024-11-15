import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_cursos_front/pages/usuario/curso_page.dart';
import 'package:sistema_cursos_front/services/courses_service.dart';
import 'package:sistema_cursos_front/services/user_service.dart';
import 'package:sistema_cursos_front/widgets/no_courses.dart';

class CursosFavoritosPage extends StatelessWidget {
  const CursosFavoritosPage({super.key});

  @override
  Widget build(BuildContext context) {

    final userService = Provider.of<UserService>(context);
    final coursesService = Provider.of<CoursesService>(context);

    final purchasedCourses = coursesService.getCoursesById(userService.getUserCourses);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Center(child: Text("Mis cursos", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
            const SizedBox(height: 20),
            Expanded(
              child: purchasedCourses.isNotEmpty ? ListView.builder(
                itemCount: purchasedCourses.length,
                itemBuilder: (context, index) {
                  final course = purchasedCourses[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CursoPage(course: course, permission: true,),
                          ),
                        );
                    },
                    child: Card(
                      elevation: 5,
                      color: Colors.grey.shade200,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: SizedBox(
                              width: 70,
                              height: 100,
                              child: Image.network(
                                course.image!,
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(course.name, style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(height: 8),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            // Row(
                                            //   children: [
                                            //     Container(
                                            //       height: 8,
                                            //       width: 80,
                                            //       decoration: BoxDecoration(
                                            //         color: Colors.blue,
                                            //         borderRadius: BorderRadius.only(
                                            //           topLeft: Radius.circular(4),
                                            //           bottomLeft: Radius.circular(4),
                                            //         ),
                                            //       ),
                                            //     ),
                                            //     Container(
                                            //       height: 8,
                                            //       width: 20,
                                            //       decoration: BoxDecoration(
                                            //         color: Colors.grey, // Color restante
                                            //         borderRadius: BorderRadius.only(
                                            //           topRight: Radius.circular(4),
                                            //           bottomRight: Radius.circular(4),
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                            // SizedBox(height: 8),
                                            // Text("80% Completado"),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ) : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  NoCourses(description: 'Aún no tienes cursos comprados',)

                ],
              ),
            )
          ],
        )
      ),
    );
  }
}