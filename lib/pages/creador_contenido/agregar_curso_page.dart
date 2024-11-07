import 'package:flutter/material.dart';
import 'package:sistema_cursos_front/widgets/input_decoration.dart';

class AgregarCursoPage extends StatefulWidget {
  const AgregarCursoPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AgregarCursoPageState createState() => _AgregarCursoPageState();
}

class _AgregarCursoPageState extends State<AgregarCursoPage> {
  final _formKey = GlobalKey<FormState>();
  List<Map<String, TextEditingController>> lessons = [];

  void _addLesson() {
    setState(() {
      lessons.add({
        'title': TextEditingController(),
        'url': TextEditingController(),
      });
    });
  }

  @override
  void dispose() {
    // Liberar controladores de los campos dinámicos
    for (var lesson in lessons) {
      lesson['title']?.dispose();
      lesson['url']?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text('Agregar nuevo curso', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF14919B))),
              ),
              const SizedBox(height: 40),
              TextFormField(
                decoration: inputDecoration("Nombre", "Ejemplo: Curso de Flutter", Icons.person),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: inputDecoration("Descripción", "Describe el curso brevemente", Icons.description),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: inputDecoration("Precio", "Ejemplo: 100", Icons.attach_money),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: inputDecoration("Duración", "Ejemplo: 10 horas", Icons.access_time),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: inputDecoration("Autor", "Nombre del autor", Icons.person),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: inputDecoration("Idioma", "Ejemplo: Español", Icons.language),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  // Aquí va la lógica para subir una imagen
                },
                icon: Icon(Icons.image),
                label: Text("Subir Imagen", style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  iconColor: Colors.white,
                  backgroundColor: Color(0xFF213A57),
                ),
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
                      controller: lesson['title'],
                      decoration: inputDecoration("Título de la Lección", "Ejemplo: Introducción", Icons.title),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: lesson['url'],
                      decoration: inputDecoration("URL de la Lección", "Ejemplo: https://example.com", Icons.link),
                    ),
                    SizedBox(height: 20),
                  ],
                );
              }).toList(),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                  onPressed: _addLesson,
                  icon: Icon(Icons.add),
                  label: Text("Agregar Lección", style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF213A57),
                    iconColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Procesar los datos del formulario
                  }
                },
                child: Text("Guardar", style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF213A57),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
