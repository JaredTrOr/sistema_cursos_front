import 'package:flutter/material.dart';

class CarritoComprasPage extends StatefulWidget {
  @override
  _CarritoComprasPageState createState() => _CarritoComprasPageState();
}

class _CarritoComprasPageState extends State<CarritoComprasPage> {
  // Ejemplo de lista de cursos en el carrito de compras
  List<Map<String, dynamic>> cartItems = [
    {
      'title': 'Flutter Básico',
      'price': 29.99,
      'author': 'Juan Pérez',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT7HZFCI0Euwzq8qotUFeCbHhhISYdqUt4rg&s'
    },
    {
      'title': 'Dart Avanzado',
      'price': 19.99,
      'author': 'Ana López',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT7HZFCI0Euwzq8qotUFeCbHhhISYdqUt4rg&s'
    },
    {
      'title': 'Diseño UI/UX en Flutter',
      'price': 24.99,
      'author': 'Luis García',
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT7HZFCI0Euwzq8qotUFeCbHhhISYdqUt4rg&s'
    },
  ];

  // Método para calcular el total
  double getTotal() {
    return cartItems.fold(0, (sum, item) => sum + item['price']);
  }

  // Método para quitar un curso del carrito
  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ListTile(
                    leading: Image.network(item['image'], width: 100, fit: BoxFit.cover,),
                    title: Text(item['title'], style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Autor: ${item['author']}'),
                        Text('Precio: \$${item['price'].toStringAsFixed(2)}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () => removeItem(index),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('\$${getTotal().toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 20),
                MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  padding: EdgeInsets.all(20),
                  color: Color(0xFF14919B),
                  onPressed: () {
                    Navigator.pushNamed(context, 'metodo_pago');
                  },
                  // onPressed: loginForm.isLoading 
                  //   ? null 
                  //   : () async {
                  //     FocusScope.of(context).unfocus();
                  //     if (!loginForm.isValidForm()) return;
            
                  //     loginForm.isLoading = true;
            
                  //     await Future.delayed(const Duration(seconds: 2));
            
                  //     loginForm.isLoading = false;
                  //     Navigator.pushReplacementNamed(context, 'home');
                  //   }
                  // ,
                  child: Text(
                    'Comprar',
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
