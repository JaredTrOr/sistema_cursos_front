import 'package:flutter/material.dart';

class CursosFavoritosPage extends StatelessWidget {
  const CursosFavoritosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Card(
      elevation: 5,
      color:Colors.grey.shade200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 20),
          ListTile(
            leading: SizedBox(
              width: 70,
              height: 80,
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT7HZFCI0Euwzq8qotUFeCbHhhISYdqUt4rg&s',
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ultimate JavaScript: de cero a programador experto", style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 8), 
               Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                           Row(
                  children: [
                    Container(
                      height: 8, 
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.blue, 
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        ),
                      ),
                    ),
                    Container(
                      height: 8, 
                      width: 20, 
                      decoration: BoxDecoration(
                        color: Colors.grey, // Color restante
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8), 
                Text("80% Completado"),
                        ],
                      ),
                      SizedBox(width: 50,),
                      Icon(Icons.pause, size: 50)
                    ],
                  )
                ],
               )
              ],
            ),
          ),
        ],
      ),
    ),
    Card(
      elevation: 5,
      color:Colors.grey.shade200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 20),
          ListTile(
            leading: SizedBox(
              width: 70,
              height: 80,
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT7HZFCI0Euwzq8qotUFeCbHhhISYdqUt4rg&s',
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ultimate JavaScript: de cero a programador experto", style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 8), 
               Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                           Row(
                  children: [
                    Container(
                      height: 8, 
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue, 
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        ),
                      ),
                    ),
                    Container(
                      height: 8, 
                      width: 50, 
                      decoration: BoxDecoration(
                        color: Colors.grey, // Color restante
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8), 
                Text("50% Completado"),
                        ],
                      ),
                      SizedBox(width: 50,),
                      Icon(Icons.pause, size: 50)
                    ],
                  )
                ],
               )
              ],
            ),
          ),
        ],
      ),
    )
          ],
        )
      ),
    );
  }
}