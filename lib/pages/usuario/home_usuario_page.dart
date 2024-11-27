import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_cursos_front/pages/usuario/curso_page.dart';
import 'package:sistema_cursos_front/providers/cart_provider.dart';
import 'package:sistema_cursos_front/services/courses_service.dart';
import 'package:sistema_cursos_front/services/user_service.dart';
import 'package:sistema_cursos_front/widgets/is_loading.dart';
import 'package:sistema_cursos_front/widgets/no_courses.dart';
import 'package:sistema_cursos_front/widgets/card_curso.dart';
import 'package:sistema_cursos_front/widgets/pop_up.dart';

class HomeUsuarioPage extends StatelessWidget {
  const HomeUsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final courseService = Provider.of<CoursesService>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final userService = Provider.of<UserService>(context);

    if (courseService.isLoading) {
      return const IsLoading();
    }    

     print("courseService.isLoading: ${courseService.isLoading}");
      print("courseService.courses.length: ${courseService.courses.length}");


      for (var course in courseService.courses) {
        print(course.name);
        print(course.image);
      }


    return Scaffold(
      body: courseService.courses.isNotEmpty ? 
      ListView.builder(
        itemCount: courseService.courses.length,
        itemBuilder: (context, index) {
          final course = courseService.courses[index];
      
          bool isPurchased = userService.isBeingPurchased(course.id!);

          print('IMAGE');
          print(course.image!);
          return CardCurso(
            course: course,
            onAdd: () {
              if (!cartProvider.isTheElementInCart(course)) {
                cartProvider.addCourseToCart(course);
                popUp(context: context, title: 'Agregado', body: 'Curso agregado al carrito', dialogType: 'success');
                return;
              }
      
              popUp(context: context, title: 'Atención', body: 'Este curso ya esta en el carrito', dialogType: 'info');
            },
            onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CursoPage(course: course, permission: isPurchased,),
                        ),
                      );
            },
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
      )
      : const NoCourses(description: 'No hay cursos disponibles',),
    );
  }
}
