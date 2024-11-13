import 'package:flutter/material.dart';
import 'package:sistema_cursos_front/pages/usuario/curso_page.dart';
import 'package:sistema_cursos_front/widgets/perfil_appbar.dart';

// Modelo para un curso
class Curso {
  final String titulo;
  final String descripcion;
  final String autor;
  final String imagenUrl;
  final String precio;

  Curso({
    required this.titulo,
    required this.descripcion,
    required this.autor,
    required this.imagenUrl,
    required this.precio
  });
}

class CursosCreadorContenidoPage extends StatelessWidget {
  CursosCreadorContenidoPage({super.key});

  // Lista de cursos (puede ser obtenida de una API o fuente de datos)
  final List<Curso> cursos = [
    Curso(
      titulo: 'Curso de Java',
      descripcion: 'Aprende el lenguaje de Java.',
      autor: 'Rulas',
      imagenUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT7HZFCI0Euwzq8qotUFeCbHhhISYdqUt4rg&s',
      precio: '800'
    ),
    // Agregar más cursos si es necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),
          Expanded(
            child: ListView.builder(
              itemCount: cursos.length,
              itemBuilder: (context, index) {
                final curso = cursos[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CursoPage(
                          title: curso.titulo,
                          subtitle: curso.descripcion,
                          image: curso.imagenUrl,
                          price: curso.precio,
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
                                child: Image.network(curso.imagenUrl),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    curso.titulo,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    curso.descripcion,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    curso.autor,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'editar_curso', arguments: curso);
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
                                  // Lógica para eliminar el curso
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
              },
            ),
          ),
          const SizedBox(height: 50),
          // Botón para agregar curso
          Card(
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
              child: Row(
                children: [
                  const SizedBox(width: 60),
                  const Icon(Icons.add_circle_outline_rounded, color: Color(0xFF14919B), size: 35),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'agregar_curso');
                    },
                    child: const Text(
                      "Agregar Curso",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF14919B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
