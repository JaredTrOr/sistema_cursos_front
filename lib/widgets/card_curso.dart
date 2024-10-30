import 'package:flutter/material.dart';

class CardCurso extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final String price;
  final VoidCallback onTap; 
  final VoidCallback onFavorite; // Callback para manejar el clic en el favorito
  final bool isFavorite; // Nuevo parámetro para indicar si es favorito

  const CardCurso({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.price,
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
          children: <Widget>[
            SizedBox(height: 20),
            ListTile(
              leading: SizedBox(
                width: 80,
                height: 80,
                child: Image.network(image),
              ),
              title: Text(title),
              subtitle: Text(subtitle),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('Agregar', style: TextStyle(color: Color(0xFF14919B)),),
                  onPressed: () {}, 
                ),
                const SizedBox(width: 60),
                Text(price),
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
