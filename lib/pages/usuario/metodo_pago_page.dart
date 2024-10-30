import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class MetodoPagoPage extends StatefulWidget {
  const MetodoPagoPage({super.key});

  @override
  _MetodoPagoPageState createState() => _MetodoPagoPageState();
}

class _MetodoPagoPageState extends State<MetodoPagoPage> {
  List<String> metodosPago = ["Visa", "Paypal"];
  List<String> nuevosMetodosPago = [];

  String cardNumber = '', expiryDate = '', cardHolderName = '', cvvCode = '';
  bool isCvvFocused = false;
  String tipoTarjeta = "Visa";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _mostrarDialogo(bool isEditMode, [int? index]) {
    String cardNumber =
        isEditMode ? nuevosMetodosPago[index!].split(", ")[1] : '';
    String expiryDate = isEditMode
        ? nuevosMetodosPago[index!].split(", ")[2].split("Exp: ")[1]
        : '';
    String cardHolderName = isEditMode
        ? nuevosMetodosPago[index!].split(", ")[0].split(": ")[1]
        : '';
    String cvvCode = '';
    // bool isCvvFocused = false;

    // final TextEditingController cardHolderNameController =
    //     TextEditingController(text: cardHolderName);
    // final TextEditingController cardNumberController =
    //     TextEditingController(text: cardNumber);
    // final TextEditingController expiryDateController =
    //     TextEditingController(text: expiryDate);

    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      title: isEditMode ? 'Editar Método de Pago' : 'Agregar Método de Pago',
      body: Column(
        children: [
          DropdownButtonFormField<String>(
            value: tipoTarjeta,
            items: [
              'Visa',
              'Paypal',
            ].map((String tipo) {
              return DropdownMenuItem<String>(
                value: tipo,
                child: Text(tipo),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                tipoTarjeta = value!;
              });
            },
            decoration: _inputDecoration('Tipo de Tarjeta', ''),
          ),
          CreditCardForm(
            formKey: formKey,
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            onCreditCardModelChange: (CreditCardModel? creditCardModel) {
              if (creditCardModel != null) {
                cardNumber = creditCardModel.cardNumber;
                expiryDate = creditCardModel.expiryDate;
                cardHolderName = creditCardModel.cardHolderName;
                cvvCode = creditCardModel.cvvCode;
                isCvvFocused = creditCardModel.isCvvFocused;
              }
            },
            themeColor: Colors.blue,
            cardNumberDecoration:
                _inputDecoration('Número de Tarjeta', 'XXXX XXXX XXXX XXXX'),
            expiryDateDecoration:
                _inputDecoration('Fecha de Expiración', 'MM/AA'),
            cvvCodeDecoration: _inputDecoration('CVV', 'XXX'),
            cardHolderDecoration: _inputDecoration('Nombre del Titular', ''),
          ),
          SizedBox(height: 20),
        ],
      ),
      btnOkOnPress: () {
        // if (formKey.currentState!.validate()) {
        //   setState(() {
        //     String newMetodo =
        //         '$tipoTarjeta: $cardHolderName, $cardNumber, Exp: $expiryDate';
        //     if (isEditMode) {
        //       nuevosMetodosPago[index!] = newMetodo;
        //     } else {
        //       nuevosMetodosPago.add(newMetodo);
        //     }
        //   });
        // }
      },
      btnCancelOnPress: () {},
    ).show();
  }

  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel?.cardNumber ?? '';
      expiryDate = creditCardModel?.expiryDate ?? '';
      cardHolderName = creditCardModel?.cardHolderName ?? '';
      cvvCode = creditCardModel?.cvvCode ?? '';
      isCvvFocused = creditCardModel?.isCvvFocused ?? false;
    });
  }

  void _eliminarMetodoPago(int index) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      title: 'Eliminar Método de Pago',
      desc: '¿Estás seguro de eliminar este método?',
      btnOkText: 'Eliminar',
      btnOkOnPress: () => setState(() => nuevosMetodosPago.removeAt(index)),
      btnCancelOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 64, bottom: 16),
              child: const Text(
                'Métodos de Pago',
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
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    _mostrarDialogo(false);
                  },
                  child: _metodoPagoCard(metodosPago[index]),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 64, bottom: 16),
              child: const Text(
                'Disponibles',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF14919B),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: nuevosMetodosPago.length,
              itemBuilder: (context, index) {
                return _metodoPagoCard(
                  nuevosMetodosPago[index],
                  onEdit: () => _mostrarDialogo(true, index),
                  onDelete: () => _eliminarMetodoPago(index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _metodoPagoCard(String metodoPago, { VoidCallback? onEdit, VoidCallback? onDelete }) {

    print('MÉTODO DE PAGO');
    print(metodoPago);
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF14919B), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [ 
          Image(
            image: AssetImage(
                'assets/${metodoPago.contains(':') ? metodoPago.split(":")[0].toLowerCase() : metodoPago}.png'),
            width: 50,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              metodoPago,
              style: TextStyle(fontSize: 16),
            ),
          ),
          if (onEdit != null && onDelete != null) ...[
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ],
      ),
    );
  }
}
