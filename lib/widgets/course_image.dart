import 'dart:io';

import 'package:flutter/material.dart';

class CourseImage extends StatelessWidget {
  final String? url;
  const CourseImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10, right: 10, top: 10
      ),
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10, 
              offset: const Offset(0,5)
            )
          ]
        ),
        child: Opacity(
          opacity: 0.8,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45)
            ),
            child: 
            getImage(url)
          ),
        ),
      ),
    );
  }

  Widget getImage(String? imagen) {
    print('AQUI RANDOM EN GET IMAGE');
    print(imagen);
    if (imagen == null) {
      return const Image(image: AssetImage('assets/no-image.png'), fit: BoxFit.cover,);
    }

    if (imagen.startsWith('http')) {
      return FadeInImage(
        placeholder: const AssetImage('assets/jar-loading.gif'), 
        image: NetworkImage(url!),
        fit: BoxFit.cover,
      );
    }

    return Image.file(
      File(imagen),
      fit: BoxFit.cover,
    );
  } 
}