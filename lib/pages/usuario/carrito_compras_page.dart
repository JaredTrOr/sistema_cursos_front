import 'package:flutter/material.dart';

class CarritoComprasPage extends StatelessWidget {
  const CarritoComprasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Title(color: Colors.black, child: Text("Carrito Compras")))
      )
    );
  }
}