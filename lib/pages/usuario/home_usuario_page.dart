import 'package:flutter/material.dart';
import 'package:sistema_cursos_front/widgets/search_productos.dart';
import 'package:sistema_cursos_front/pages/usuario/curso_page.dart';
import 'package:sistema_cursos_front/widgets/card_curso.dart';
import 'cursos_adquiridos_page.dart'; // Asegúrate de importar la página de cursos adquiridos

class HomeUsuarioPage extends StatefulWidget {
  const HomeUsuarioPage({super.key});

  @override
  _HomeUsuarioPageState createState() => _HomeUsuarioPageState();
}

class _HomeUsuarioPageState extends State<HomeUsuarioPage> {
  final List<Map<String, String>> cursos = [
     {
        'title': 'The Enchanted Nightingale',
        'subtitle': 'Music by Julie Gable. Lyrics by Sidney Stein.',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT7HZFCI0Euwzq8qotUFeCbHhhISYdqUt4rg&s',
        'price':'\$390.00',
      },
      {
        'title': 'Curso de Flutter',
        'subtitle': 'Aprende a desarrollar aplicaciones móviles.',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT7HZFCI0Euwzq8qotUFeCbHhhISYdqUt4rg&s',
        'price':'\$450.00',
      },
      {
        'title': 'Curso de Dart',
        'subtitle': 'Domina el lenguaje de programación.',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT7HZFCI0Euwzq8qotUFeCbHhhISYdqUt4rg&s',
        'price':'\$560.00',
      },
      {
        'title': 'Curso de Java',
        'subtitle': 'Aprende el lenguaje de Java.',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT7HZFCI0Euwzq8qotUFeCbHhhISYdqUt4rg&s',
        'price':'\$850.00',
      },
      {
        'title': 'Curso de C',
        'subtitle': 'Aprende a programar en C.',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT7HZFCI0Euwzq8qotUFeCbHhhISYdqUt4rg&s',
        'price':'\$650.00',
      },
      {
        'title': 'Curso de C++',
        'subtitle': 'Aprende a programar en C++.',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT7HZFCI0Euwzq8qotUFeCbHhhISYdqUt4rg&s',
        'price':'\$650.00',
      }
  ];

  // Mapa para manejar el estado de favorito
  final Map<String, bool> favoritos = {};

  @override
  void initState() {
    super.initState();
    // Inicializa el estado de favoritos como falso para todos los cursos
    for (var curso in cursos) {
      favoritos[curso['title']!] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Builder(builder: (context) {
                      return ElevatedButton(
                        onPressed: () {
                          showSearch(context: context, delegate: SearchProductos(cursos: cursos));
                        },
                        child: const Icon(Icons.search),
                      );
                    }),
                  ),
                ],
              ),
              ...cursos.map((curso) {
                return CardCurso(
                  title: curso['title']!,
                  subtitle: curso['subtitle']!,
                  image: curso['image']!,
                  price: curso['price']!,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CursoPage(
                          title: curso['title']!,
                          subtitle: curso['subtitle']!,
                          image: curso['image']!,
                          price: curso['price']!,
                        ),
                      ),
                    );
                  },
                  onFavorite: () {
                    setState(() {
                      // Cambia el estado de favorito
                      favoritos[curso['title']!] = !favoritos[curso['title']!]!;
                    });
                    if (favoritos[curso['title']!]!) {
                      cursosAdquiridos.add(curso);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${curso['title']} agregado a Mis Cursos')),
                      );
                    }
                  },
                  isFavorite: favoritos[curso['title']]!, // Pasa el estado de favorito
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
