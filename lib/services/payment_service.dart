import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sistema_cursos_front/models/payment_model.dart';

class PaymentService extends ChangeNotifier {

  bool isLoading = false;
  List<PaymentModel> paymentMethods = [];
  String? ownerId;

  final _db = FirebaseFirestore.instance;

  PaymentService(this.ownerId) {
    getPaymentMethods();
  }

  Future<Map<String, dynamic>> addPaymentMethod(PaymentModel paymentModel) async {
    try {
      isLoading = true;
      notifyListeners();

      DocumentReference docRef = await _db.collection('payment').add(paymentModel.toJson());
      DocumentSnapshot docSnapshot = await docRef.get();
      PaymentModel payment = PaymentModel.fromJson({
        'id': docSnapshot.id,
        ...docSnapshot.data() as Map<String, dynamic>
      });

      paymentMethods.add(payment);

      isLoading = false;
      notifyListeners();
      return {'success': true, 'message': 'Pago realizado exitosamente', 'data': payment};
    } catch (e) {
      print('ERROR');
      print(e);
      isLoading = false;
      notifyListeners();
      return {'success': false, 'message': 'Error al realizar el pago', 'error': e};
    }
  }

  Future<void> getPaymentMethods() async {
    try {
      isLoading = true;
      notifyListeners();

      QuerySnapshot query = await _db.collection('payment')
      .where('ownerId', isEqualTo: ownerId)
      .get();
      paymentMethods.clear();

      paymentMethods.addAll(query.docs.map((doc) => PaymentModel.fromJson({
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>
      })).toList());

      isLoading = false;
      notifyListeners();
    } catch (e) {
      print('ERROR getPaymentMethods');
      print(e);
      isLoading = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> removePaymentMethod(int index) async {
    try {
      isLoading = true;
      notifyListeners();

      PaymentModel paymentToRemove = paymentMethods[index];
      await _db.collection('payment').doc(paymentToRemove.id).delete();
      paymentMethods.removeAt(index);

      isLoading = false;
      notifyListeners();

      return {'success': true, 'message': 'Método de pago eliminado exitosamente'};
    } catch (e) {
      print('ERROR removePaymentMethod');
      print(e);
      isLoading = false;
      notifyListeners();

      return {'success': false, 'message': 'Error al eliminar el método de pago', 'error': e};
    }
  }

}