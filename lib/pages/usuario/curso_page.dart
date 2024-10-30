import 'package:flutter/material.dart';
import 'package:sistema_cursos_front/widgets/perfil_appbar.dart';

class CursoPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final String price;

 const CursoPage({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.price,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPerfil(arrow: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
        
            Container(
              height: 50,
              child: Center(  
                child: Text(title, style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFF0B6477),
                  fontWeight: FontWeight.bold
                ),),
              
              ),
            ),
            Column(
        children: [
          Image.network(image),
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.center,
            child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(subtitle, style: 
                  TextStyle(
                    color: Color(0xFF0B6477)),),
                      ),
          ),
          Padding(
            padding: const EdgeInsets.all(27),
            child: Padding(
          padding: const EdgeInsets.all(16.0), // Ajusta el valor según necesites
          child: Row(
            children: [
        const Expanded( // Esto asegura que el contenido ocupe el espacio disponible
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.favorite_border_outlined, size: 40),
                  SizedBox(width: 10), // Espacio entre el texto y el ícono
                  Text("\15", style: 
                  TextStyle(
                    color: Color(0xFF0B6477),
                    fontSize: 25),
                    ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.language, size: 40),
                  SizedBox(width: 10),
                  Text("Español",style: 
                  TextStyle(
                    color: Color(0xFF0B6477),
                    fontSize: 15),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.warning, size: 40),
                  SizedBox(width: 10),
                  Text("Ultima Actualizacion",style: 
                  TextStyle(
                    color: Color(0xFF0B6477),
                    fontSize: 15),
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
              child: Text(price,
              style: 
                  TextStyle(
                    fontSize: 25,
                    color: Color(0xFF213A57),
                    fontWeight: FontWeight.bold),
                    ),
                    
            ),
            ElevatedButton(onPressed: (){}, 
            child: Text("Agregar",
            style: TextStyle(
              color: Colors.white
            ),
            ),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color(0xFF213A57))
            ),
            )
          ],
        ),
            ],
          ),
        )
        
          ),
        ],
            ),
              ElevatedButton(
                
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xFF0B6477)),
                  minimumSize: WidgetStatePropertyAll(Size(350,50)),
                  shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // Radio de los bordes
                  ),
                  ),
                  ),
                onPressed: (){}, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
                  children: [
                    
                    Text("Lección 1", 
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white),
                          ),
                          
                          SizedBox(width: 8),
                          Icon(Icons.lock_rounded, size: 35,color: Colors.white,),
                  ],
                ),
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xFF0B6477)),
                  minimumSize: WidgetStatePropertyAll(Size(350,50)),
                  shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // Radio de los bordes
                  ),
                  ),
                  ),
                onPressed: (){}, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Lección 2", 
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.lock_rounded, size: 35,color: Colors.white,),
                  ],
                ),
                      
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xFF0B6477)),
                  minimumSize: WidgetStatePropertyAll(Size(350,50)),
                  shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // Radio de los bordes
                  ),
                  ),
                  ),
                onPressed: (){}, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Lección 3", 
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.lock_rounded, size: 35,color: Colors.white,)
                  ],
                ),
                      ),
          ],
        ),
      ),
    );
  }
}
