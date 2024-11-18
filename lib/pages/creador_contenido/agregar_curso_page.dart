import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sistema_cursos_front/models/courses_model.dart';
import 'package:sistema_cursos_front/services/courses_service.dart';
import 'package:sistema_cursos_front/widgets/course_image.dart';
import 'package:sistema_cursos_front/widgets/input_decoration.dart';
import 'package:sistema_cursos_front/widgets/is_loading.dart';
import 'package:sistema_cursos_front/widgets/perfil_appbar.dart';
import 'package:sistema_cursos_front/widgets/pop_up.dart';

class AgregarCursoPage extends StatefulWidget {

  const AgregarCursoPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AgregarCursoPageState createState() => _AgregarCursoPageState();
}

class _AgregarCursoPageState extends State<AgregarCursoPage> {
  final _formKey = GlobalKey<FormState>();
  List<dynamic> lessons = [];

  void _addLesson() {
    setState(() {
      lessons.add({
        'title': '',
        'url': '',
      });
    });
  }

  void _removeLesson() {
    setState(() {
      lessons.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {

    final arguments = ModalRoute.of(context)!.settings.arguments as List<dynamic>?;

    final courseService = arguments![0] as CoursesService;
    final newCourse = arguments[1] as Course;

    lessons = newCourse.lessons;

    return Scaffold(
      appBar: const AppBarPerfil(arrow: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Center(
                child: Text('Agregar nuevo curso', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF14919B))),
              ),
              CourseImage(url: courseService.selectedCourse!.image),

              const SizedBox(height: 40),

               ElevatedButton.icon(
                onPressed: () async {
                  // Aquí va la lógica para subir una imagen
                  final picker = ImagePicker();
                  final XFile? archivoSeleccionado = await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
                  if (archivoSeleccionado == null) {
                    print('No se seleccionó nada');
                    return;
                  }

                  setState(() {
                    courseService.updateImage(archivoSeleccionado.path);
                  });
                },
                icon: const Icon(Icons.image),
                label: const Text("Subir Imagen", style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  iconColor: Colors.white,
                  backgroundColor: const Color(0xFF213A57),
                ),
              ),
              const SizedBox(height: 20),

              TextFormField(
                initialValue: newCourse.name,
                onChanged: (value) => newCourse.name = value,
                decoration: inputDecoration("Nombre", "Ejemplo: Curso de Flutter", Icons.person),
                validator: (value) { 
                if (value == null || value.length <= 3) {
                  return 'El nombre debe tener al menos 3 caracteres';
                }
                
              },
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: newCourse.description,
                onChanged: (value) => newCourse.description = value,
                decoration: inputDecoration("Descripción", "Describe el curso brevemente", Icons.description),
                validator: (value) { 
                if (value == null || value.length <= 5) {
                  return 'La descripción debe tener al menos 10 caracteres';
                }
              },
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: newCourse.price.toString(),
                onChanged: (value) {
                  if (double.tryParse(value) == null) {
                    newCourse.price = 0;
                  }
                  else {
                    newCourse.price = double.parse(value);
                  }
                },
                decoration: inputDecoration("Precio", "Ejemplo: 100", Icons.attach_money),
                keyboardType: TextInputType.number,
                validator: (value) {
                if (value == null || double.tryParse(value) == null) {
                  return 'El precio debe ser un número válido';
                }
                }
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: newCourse.timeDuration,
                onChanged: (value) => newCourse.timeDuration = value,
                decoration: inputDecoration("Duración", "Ejemplo: 10 horas", Icons.access_time),
                validator: (value) {
                  if (value == null || value.length <= 3) {
                    return 'La duración debe tener al menos 3 caracteres';
                  }
                }
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: newCourse.author,
                onChanged: (value) => newCourse.language = value,
                decoration: inputDecoration("Autor", "Nombre del autor", Icons.person),
                validator: (value) {
                  if (value == null || value.length <= 3) {
                    return 'El autor debe tener al menos 3 caracteres';
                  }
                }
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: newCourse.language,
                onChanged: (value) => newCourse.language = value,
                decoration: inputDecoration("Idioma", "Ejemplo: Español", Icons.language),
                validator: (value) {
                  if (value == null || value.length <= 3) {
                    return 'El idioma debe tener al menos 3 caracteres';
                  }
                }
              ),
              const SizedBox(height: 20),
              const Text(
                "Número de Lecciones",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...lessons.map((lesson) {
                // int index = lessons.indexOf(lesson);
                return Column(
                  children: [
                    TextFormField(
                      initialValue: lesson['title'],
                      onChanged: (value) => lesson['title'] = value,
                      decoration: inputDecoration("Título de la Lección", "Ejemplo: Introducción", Icons.title),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: lesson['url'],
                      onChanged: (value) => lesson['url'] = value,
                      decoration: inputDecoration("URL de la Lección", "Ejemplo: https://example.com", Icons.link),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }).toList(),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: _addLesson,
                      icon: const Icon(Icons.add),
                      label: const Text("Agregar Lección", style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF213A57),
                        iconColor: Colors.white,
                      ),
                    ),

                    lessons.isNotEmpty ? 
                    ElevatedButton.icon(
                      onPressed: () {
                        _removeLesson(); 
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text("Borrar leccion", style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF213A57),
                        iconColor: Colors.white,
                      ),
                    ) : Container()

                  ],
                )
              ),
              const SizedBox(height: 30),
              courseService.isLoading ? const IsLoading() : ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (lessons.isEmpty) {
                      popUp(context: context, title: 'Error', body: 'Debe agregar al menos una lección', dialogType: 'warning');
                      return;
                    }

                    newCourse.lessons = lessons;

                    final String? imageUrl = await courseService.subirImagen();

                    if (imageUrl != null) {
                      newCourse.image = imageUrl;
                    }

                    if (newCourse.id == null) {
                      courseService.addCourse(newCourse)
                      .then((response) {
                        if (response['success']) {
                          Navigator.pop(context);
                        } else {
                          popUp(context: context, title: 'Hubo un error', body: 'Hubo un problema al agregar el curso', dialogType: 'warning');

                        }
                      }).catchError((error) {
                        popUp(context: context, title: 'Hubo un error', body: 'Error al agregar curso', dialogType: 'error');
                        print(error);
                      });

                    } else {
                      courseService.updateCourse(newCourse)
                      .then((response) {
                        if (response['success']) {
                          Navigator.pop(context);
                        } else {
                          popUp(context: context, title: 'Hubo un error', body: 'Hubo un problema al actualizar el curso', dialogType: 'warning');
                        }
                      }).catchError((error) {
                        popUp(context: context, title: 'Hubo un error', body: 'Error al actualizar curso', dialogType: 'error');
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF213A57),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Guardar", style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
