import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';
import 'package:sistema_cursos_front/models/payment_model.dart';
import 'package:sistema_cursos_front/models/purchase_model.dart';
import 'package:sistema_cursos_front/providers/cart_provider.dart';
import 'package:sistema_cursos_front/services/payment_service.dart';
import 'package:sistema_cursos_front/services/purchase_service.dart';
import 'package:sistema_cursos_front/services/user_service.dart';
import 'package:sistema_cursos_front/widgets/is_loading.dart';
import 'package:sistema_cursos_front/widgets/no_courses.dart';
import 'package:sistema_cursos_front/widgets/pop_up.dart';
import 'package:sistema_cursos_front/widgets/pop_up_confirmation.dart';

class MetodoPagoPage extends StatefulWidget {
  const MetodoPagoPage({super.key});

  @override
  _MetodoPagoIntialitationState createState() => _MetodoPagoIntialitationState();
}

class _MetodoPagoIntialitationState extends State<MetodoPagoPage> {
  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PurchaseService(userService.userProvider.id)),
        ChangeNotifierProvider( create: (context) => PaymentService(userService.userProvider.id))
      ],
      child: MetodoPagoContent(userService: userService),
    );
  }
}

class MetodoPagoContent extends StatefulWidget {
  final UserService userService;
  const MetodoPagoContent({Key? key, required this.userService}) : super(key: key);

  @override
  State<MetodoPagoContent> createState() => _MetodoPagoContentState();
}

class _MetodoPagoContentState extends State<MetodoPagoContent> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> metodosPago = ["Visa", "Paypal"];
  String cardNumber = '', expiryDate = '', cardHolderName = '', cvvCode = '';
  bool isCvvFocused = false;
  String tipoTarjeta = "Visa";

  void _mostrarDialogo(String tipoTarjeta, UserService userService, PaymentService paymentService) {
    // Reset values each time the dialog is shown
    cardNumber = '';
    expiryDate = '';
    cardHolderName = '';
    cvvCode = '';

    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      title: 'Agregar Método de Pago - $tipoTarjeta',
      body: Column(
        children: [
          Text('Agregar Método de Pago - $tipoTarjeta', style: const TextStyle(fontWeight: FontWeight.bold),),
          CreditCardForm(
            formKey: formKey,
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            onCreditCardModelChange: (CreditCardModel? creditCardModel) {
              if (creditCardModel != null) {
                setState(() {
                  cardNumber = creditCardModel.cardNumber;
                  expiryDate = creditCardModel.expiryDate;
                  cardHolderName = creditCardModel.cardHolderName;
                  cvvCode = creditCardModel.cvvCode;
                  isCvvFocused = creditCardModel.isCvvFocused;
                });
              }
            },
            themeColor: Colors.blue,
            cardNumberDecoration:
                _inputDecoration('Número de Tarjeta', 'XXXX XXXX XXXX XXXX'),
            expiryDateDecoration: _inputDecoration('Fecha de Expiración', 'MM/AA'),
            cvvCodeDecoration: _inputDecoration('CVV', 'XXX'),
            cardHolderDecoration: _inputDecoration('Nombre del Titular', ''),
          ),
          const SizedBox(height: 20),
        ],
      ),
      btnOkOnPress: () {
        if (formKey.currentState!.validate()) {
          
          final payment = PaymentModel(
            cardType: tipoTarjeta,
            cardNumber: cardNumber,
            cardHolder: cardHolderName,
            expirationDate: expiryDate,
            cvv: cvvCode,
            ownerId: userService.userProvider.id!,
          );

          paymentService.addPaymentMethod(payment).then((response) {
            if (response['success']) {
              // popUp(context: context, title: 'Método de Pago Agregado', body: 'Método de Pago Agregado Exitosamente', dialogType: 'success');
            } else {
              popUp(context: context, title: 'Error al Agregar Método de Pago', body: 'Error al Agregar Método de Pago', dialogType: 'error');
            }
          }).catchError((error) {
              popUp(context: context, title: 'Error de petición', body: 'Error al Agregar Método de Pago', dialogType: 'error');
          });
          // setState(() {});
        }
        else {}
      },
      btnCancelOnPress: () {},
    ).show();
  }

  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: const OutlineInputBorder(),
    );
  }

  void _eliminarMetodoPago(int index, PaymentService paymentService) {

    popUpConfirmation(
      context: context, 
      title: 'Eliminar Método de Pago', 
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Center(child: Text('¿Estás seguro de eliminar este método de pago?', style: TextStyle(fontSize: 16))),
          SizedBox(height: 20),
        ],
      ), 
      onAccept: () {
        paymentService.removePaymentMethod(index).then((response) {
        if (response['success']) {
          // popUp(context: context, title: 'Método de Pago Eliminado', body: 'Método de Pago Eliminado Exitosamente', dialogType: 'success');
        } else {
          popUp(context: context, title: 'Error al Eliminar Método de Pago', body: 'Error al Eliminar Método de Pago', dialogType: 'error');
        }
      }).catchError((error) {
          popUp(context: context, title: 'Error de petición', body: 'Error al Eliminar Método de Pago', dialogType: 'error');
      });
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    final paymentService = Provider.of<PaymentService>(context);
    final userService = Provider.of<UserService>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final purchaseService = Provider.of<PurchaseService>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 64),
              child: const Text(
                'Selecciona un Método de Pago',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF14919B),
                ),
              ),
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                itemCount: metodosPago.length,
                itemBuilder: (context, index) {
                  final metodo = metodosPago[index];
                  return GestureDetector(
                    onTap: () => _mostrarDialogo(metodo, userService, paymentService),
                    child: _metodoPagoCard(metodo),
                  );
                },
              ),
            ),
            const Divider(),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 16),
              child: const Text(
                'Métodos de Pago Agregados',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF14919B),
                ),
              ),
            ),
            paymentService.isLoading ? const Column(
              children: [
                SizedBox(height: 60),
                IsLoading(),
              ],
            ) :
            paymentService.paymentMethods.isNotEmpty ? 
            SizedBox(
              height: 200, // Specify the height based on your UI requirements
              child: ListView.builder(
                itemCount: paymentService.paymentMethods.length,
                itemBuilder: (context, index) {
                  final payment = paymentService.paymentMethods[index];
                  return GestureDetector(
                    onTap: () {
                      popUpConfirmation(
                        context: context, 
                        title: 'Realizar compra', 
                        body: Column(
                          children: [
                            const SizedBox(height: 10),
                            const Center(child: Text('¿Estás seguro de realizar la compra?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                            _displayProdcutsAndTotal(cartProvider),
                            const SizedBox(height: 20),
                          ],
                        ), 
                        onAccept: () {
                          final purchase = Purchase(
                            purchasedCoursesId: cartProvider.coursesCart.map((e) => e.id!).toList(), 
                            purchaseDate: DateTime.now(), 
                            buyerId: userService.userProvider.id!, 
                            total: cartProvider.getTotal()
                          );

                          purchaseService.addPurchase(purchase).then((response) {
                            if (response['success']) {
                              popUp(context: context, title: 'Compra realizada', body: 'Compra realizada exitosamente', dialogType: 'success');
                              userService.addNewPurchasedCourses(purchase.purchasedCoursesId);
                              cartProvider.reset();

                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                'navigation', // Target route (HomeUser screen)
                                ModalRoute.withName('login'), // Keep only the 'login' route in the stack
                              );
                            }
                            else {
                              popUp(context: context, title: 'Error al realizar la compra', body: 'Error al realizar la compra', dialogType: 'error');
                            }
                          });
                        }
                      );
                    },
                    child: _metodoPagoCard(
                      '${payment.cardType}',
                      onDelete: () => _eliminarMetodoPago(index, paymentService),
                      payment: payment,
                    ),
                  );
                },
              ),)
              : const Column(
                  children: [
                    SizedBox(height: 60),
                    NoCourses(description: 'No hay métodos de pago'),
                  ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _metodoPagoCard(String metodoPago, {VoidCallback? onDelete, PaymentModel? payment}) {
    return Container(
      height: 80,
      width: 180,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF14919B), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Image(
            image: AssetImage(
                'assets/${metodoPago.toLowerCase()}.png'),
            width: 50,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: 
            payment == null ?
            Text(
              metodoPago,
              style: const TextStyle(fontSize: 16),
            )
            :
            Column(
              children: [
                Text(
                  metodoPago,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  '**** **** **** ${payment.cardNumber.substring(payment.cardNumber.length - 4)}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            )
            ,
          ),
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
        ],
      ),
    );
  }

  Widget _displayProdcutsAndTotal(CartProvider cartItems) {
    return SizedBox(
      height: 230, // Set a fixed height for the container
      child: Column(
      children: [
        Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: cartItems.coursesCart.length,
          itemBuilder: (context, index) {
          final item = cartItems.coursesCart[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text(item.price.toString()),
          );
          },
        ),
        ),
        const Divider(),
        ListTile(
        title: const Text('Total', style: TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text(cartItems.getTotal().toString()),
        ),
      ],
      ),
    );
  }
}
