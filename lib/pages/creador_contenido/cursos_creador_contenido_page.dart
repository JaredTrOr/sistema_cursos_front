import 'package:flutter/material.dart';
import 'package:sistema_cursos_front/pages/widgets/perfil_appbar.dart';

class CursosCreadorContenidoPage extends StatelessWidget {
  const CursosCreadorContenidoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPerfil(arrow: true),
      body: Column(
        children: [
          SizedBox(height: 40,),
          Center(
            child: Column(
              children: [
                Card(
                  elevation: 10,
                  color: Color(0xFF213A57),
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
                              child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT7HZFCI0Euwzq8qotUFeCbHhhISYdqUt4rg&s',
                              ),
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Curso de Java',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Aprende el lenguaje de Java.',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 18,
                                  ),
                                ),
                                
                                Text(
                                  'Rulas',
                                  style: TextStyle(
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
                              onPressed: () {},
                              child: Text(
                                'Editar',
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(Color(0xFF80ED99))
                              ),
                            ),
                            SizedBox(width: 8),
                            
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'Eliminar',
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(Color(0xFF80ED99))
                              ),
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                      ],
                      
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
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
                    color: Color(0xFF14919B),
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 60,),
                    Icon(Icons.add_circle_outline_rounded, color: Color(0xFF14919B), size: 35,),
                    SizedBox(width: 15,),
                      Text(
                        "Agregar Curso",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF14919B),
                          fontWeight: FontWeight.w600,
                        ),
                    ),
                  ],
                ),
              ),
            ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}