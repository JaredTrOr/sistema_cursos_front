import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_cursos_front/providers/cart_provider.dart';
import 'package:sistema_cursos_front/widgets/no_courses.dart';

class CarritoComprasPage extends StatelessWidget {
  const CarritoComprasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: cartProvider.coursesCart.isNotEmpty
                ? ListView.builder(
                    itemCount: cartProvider.coursesCart.length,
                    itemBuilder: (context, index) {
                      final item = cartProvider.coursesCart[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: ListTile(
                          leading: Image.network(
                            item.image!,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Autor: ${item.author}'),
                              Text(
                                  'Precio: \$${item.price.toStringAsFixed(2)}'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_circle,
                                color: Colors.red),
                            onPressed: () {
                              cartProvider.removeCourseFromCart(index);
                            },
                          ),
                        ),
                      );
                    },
                  )
                : const NoCourses(
                    description: 'No hay elementos en el carrito'),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('\$${cartProvider.getTotal()}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  padding: const EdgeInsets.all(20),
                  color: const Color(0xFF14919B),
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
                  child: const Text(
                    'Comprar',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
