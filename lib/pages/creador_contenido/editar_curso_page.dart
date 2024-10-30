import 'package:flutter/material.dart';

class EditarCursoPage extends StatefulWidget {
  const EditarCursoPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditarCursoPageState createState() => _EditarCursoPageState();
}

class _EditarCursoPageState extends State<EditarCursoPage> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos de texto
  final TextEditingController _nombreController = TextEditingController(text: "Curso de Flutter Avanzado");
  final TextEditingController _descripcionController = TextEditingController(text: "Curso avanzado de Flutter para desarrollo móvil.");
  final TextEditingController _precioController = TextEditingController(text: "150");
  final TextEditingController _duracionController = TextEditingController(text: "20 horas");
  final TextEditingController _autorController = TextEditingController(text: "Juan Pérez");
  final TextEditingController _idiomaController = TextEditingController(text: "Español");

  List<Map<String, TextEditingController>> lessons = [];

  @override
  void initState() {
    super.initState();
    // Agregar lecciones de prueba
    lessons.add({
      'title': TextEditingController(text: "Introducción a Flutter"),
      'url': TextEditingController(text: "https://example.com/intro-flutter"),
    });
    lessons.add({
      'title': TextEditingController(text: "Widgets y Layouts"),
      'url': TextEditingController(text: "https://example.com/widgets-layouts"),
    });
  }

  void _addLesson() {
    setState(() {
      lessons.add({
        'title': TextEditingController(),
        'url': TextEditingController(),
      });
    });
  }

  InputDecoration _inputDecoration(String label, String hint, IconData icon) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xFF14919B), width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xFF14919B), width: 2.0),
      ),
      hintText: hint,
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey),
      prefixIcon: Icon(icon, color: Color(0xFF14919B)),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _precioController.dispose();
    _duracionController.dispose();
    _autorController.dispose();
    _idiomaController.dispose();
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
              SizedBox(height: 20),
              Center(
                child: Text('Editar curso', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF14919B))),
              ),
              SizedBox(height: 40),
              TextFormField(
                controller: _nombreController,
                decoration: _inputDecoration("Nombre", "Ejemplo: Curso de Flutter", Icons.person),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _descripcionController,
                decoration: _inputDecoration("Descripción", "Describe el curso brevemente", Icons.description),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _precioController,
                decoration: _inputDecoration("Precio", "Ejemplo: 100", Icons.attach_money),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _duracionController,
                decoration: _inputDecoration("Duración", "Ejemplo: 10 horas", Icons.access_time),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _autorController,
                decoration: _inputDecoration("Autor", "Nombre del autor", Icons.person),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _idiomaController,
                decoration: _inputDecoration("Idioma", "Ejemplo: Español", Icons.language),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  // Aquí va la lógica para subir una imagen
                },
                icon: Icon(Icons.image),
                label: Text("Subir Imagen", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  iconColor: Colors.white,
                  backgroundColor: Color(0xFF213A57),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Número de Lecciones",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ...lessons.map((lesson) {
                // int index = lessons.indexOf(lesson);
                return Column(
                  children: [
                    TextFormField(
                      controller: lesson['title'],
                      decoration: _inputDecoration("Título de la Lección", "Ejemplo: Introducción", Icons.title),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: lesson['url'],
                      decoration: _inputDecoration("URL de la Lección", "Ejemplo: https://example.com", Icons.link),
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
                  label: Text("Agregar Lección", style: TextStyle(color: Colors.white)),
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
                child: Text("Guardar", style: TextStyle(color: Colors.white)),
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
