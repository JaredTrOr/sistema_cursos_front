import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_cursos_front/models/courses_model.dart';
import 'package:sistema_cursos_front/providers/cart_provider.dart';
import 'package:sistema_cursos_front/widgets/perfil_appbar.dart';
import 'package:sistema_cursos_front/widgets/pop_up.dart';

class CursoPage extends StatelessWidget {
  final Course course;
  final bool permission;

  const CursoPage({
    Key? key,
    required this.course,
    required this.permission,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBarPerfil(arrow: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              child: Center(
                child: Text(
                  course.name,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Color(0xFF0B6477),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            course.image == null || course.image == ''
            ? const Image(image: AssetImage('assets/no-image.png'), fit: BoxFit.cover,)
                                    : FadeInImage(
                                        placeholder: const AssetImage('assets/jar-loading.gif'), 
                                        image: NetworkImage(course.image!),
                                        fit: BoxFit.cover,
                                      ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  course.description,
                  style: const TextStyle(color: Color(0xFF0B6477)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(27),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.favorite_border_outlined, size: 40),
                            const SizedBox(width: 10),
                            Text(
                              course.amountOfFavorites.toString(),
                              style: const TextStyle(
                                color: Color(0xFF0B6477),
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.language, size: 40),
                            const SizedBox(width: 10),
                            Text(
                              course.language,
                              style: const TextStyle(
                                color: Color(0xFF0B6477),
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          course.price.toString(),
                          style: const TextStyle(
                            fontSize: 25,
                            color: Color(0xFF213A57),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      permission ? Container() :
                      ElevatedButton(
                        onPressed: () {

                          if (cartProvider.isTheElementInCart(course)) {
                            popUp(
                              context: context, 
                              title: 'Elemento en carrito', 
                              body: 'El curso ya esta agregado al carrito', 
                              dialogType: 'info'
                            );
                            return;
                          }

                          cartProvider.addCourseToCart(course);
                          popUp(
                            context: context, 
                            title: 'Agregado al carrito', 
                            body: 'El curso se ha agregado al carrito', 
                            dialogType: 'success'
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: const MaterialStatePropertyAll(Color(0xFF213A57)),
                        ),
                        child: 
                        const Text(
                          "Agregar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Display the lessons based on the permission
            permission ? lessonsWithInfo(course) : lessonLockedTiles(course) 
          ],
        ),
      ),
    );
  }

  // Widget to display locked lessons
  Widget lessonLockedTiles(Course course) {
    return ListView.builder(
      shrinkWrap: true, // Allows the ListView to fit within the available space
      physics: const NeverScrollableScrollPhysics(), // Prevents nested scrolling
      itemCount: course.lessons.length,
      itemBuilder: (context, index) {
        final lesson = course.lessons[index];
        return ElevatedButton(
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Color(0xFF0B6477)),
            minimumSize: const MaterialStatePropertyAll(Size(350, 50)),
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                lesson['title'],
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.lock_rounded, size: 35, color: Colors.white),
            ],
          ),
        );
      },
    );
  }

  // Widget to display lessons with additional info
  Widget lessonsWithInfo(Course course) {
    return ListView.builder(
      shrinkWrap: true, // Allows the ListView to fit within the available space
      physics: const NeverScrollableScrollPhysics(), // Prevents nested scrolling
      itemCount: course.lessons.length,
      itemBuilder: (context, index) {
        final lesson = course.lessons[index];
        return Column(
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Color(0xFF0B6477)),
                minimumSize: const MaterialStatePropertyAll(Size(350, 50)),
                shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    lesson['title'],
                    style: const TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                lesson['description'],
                style: const TextStyle(
                  color: Color(0xFF0B6477),
                  fontSize: 20,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
