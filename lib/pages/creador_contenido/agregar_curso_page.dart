import 'package:flutter/material.dart';

class AgregarCursoPage extends StatefulWidget {
  @override
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
              SizedBox(height: 20),
              Center(
                child: Text('Agregar nuevo curso', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, backgroundColor: Color(0xFF14919B))),
              ),
              SizedBox(height: 40),
              TextFormField(
                decoration: _inputDecoration("Nombre", "Ejemplo: Curso de Flutter", Icons.person),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: _inputDecoration("Descripción", "Describe el curso brevemente", Icons.description),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: _inputDecoration("Precio", "Ejemplo: 100", Icons.attach_money),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: _inputDecoration("Duración", "Ejemplo: 10 horas", Icons.access_time),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: _inputDecoration("Autor", "Nombre del autor", Icons.person),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: _inputDecoration("Idioma", "Ejemplo: Español", Icons.language),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  // Aquí va la lógica para subir una imagen
                },
                icon: Icon(Icons.image),
                label: Text("Subir Imagen"),
                style: ElevatedButton.styleFrom(

                  backgroundColor: Color(0xFF14919B,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Número de Lecciones",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ...lessons.map((lesson) {
                int index = lessons.indexOf(lesson);
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
                  label: Text("Agregar Lección"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF14919B),
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
                child: Text("Guardar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF14919B),
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
