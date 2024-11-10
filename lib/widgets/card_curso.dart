import 'package:flutter/material.dart';
import 'package:sistema_cursos_front/models/courses_model.dart';

class CardCurso extends StatelessWidget {
  final Course course;
  final VoidCallback onTap; 
  final VoidCallback onFavorite; // Callback para manejar el clic en el favorito
  final bool isFavorite; // Nuevo parámetro para indicar si es favorito

  const CardCurso({
    super.key,
    required this.course,
    required this.onTap,
    required this.onFavorite, // Asegúrate de que este parámetro sea requerido
    required this.isFavorite, // Asegúrate de que este parámetro sea requerido
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        color: Colors.grey.shade50,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            ListTile(
              leading: SizedBox(
                width: 80,
                height: 80,
                child: 
                  course.image == '' ? 
                  Image.asset('assets/no-image.png') : 
                  FadeInImage(
                    placeholder: const AssetImage('assets/jar-loading.gif'), 
                    image: NetworkImage(course.image!)
                  )
              ),
              title: Text(course.name),
              subtitle: Text(course.description),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('Agregar', style: TextStyle(color: Color(0xFF14919B)),),
                  onPressed: () {
                  }, 
                ),
                const SizedBox(width: 60),
                Text(course.price.toString()),
                const SizedBox(width: 20),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                    color: isFavorite ? Colors.red : null, 
                  ),
                  onPressed: onFavorite, 
                ),
                const SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
