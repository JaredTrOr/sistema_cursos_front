import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_cursos_front/models/courses_model.dart';
import 'package:sistema_cursos_front/services/user_service.dart';

class CardCurso extends StatelessWidget {
  final Course course;
  final VoidCallback onTap; 
  final VoidCallback onAdd;
  final VoidCallback onFavorite; 
  final bool isFavorite; 

  const CardCurso({
    super.key,
    required this.course,
    required this.onTap,
    required this.onFavorite, 
    required this.onAdd,
    required this.isFavorite, 
  });

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    
    // Check if the course is already bought by the user
    final isBought = userService.getUserCourses.any((id) => id == course.id);

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
                  course.image == '' || course.image == null ? 
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
                if (isBought)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Comprado',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  TextButton(
                    onPressed: onAdd,
                    child: const Text(
                      'Agregar',
                      style: TextStyle(color: Color(0xFF14919B)),
                    ), 
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
