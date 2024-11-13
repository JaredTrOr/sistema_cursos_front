import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sistema_cursos_front/models/purchase_model.dart';

class PurchaseService extends ChangeNotifier {

  bool isLoading = false;
  List<Purchase> purchases = [];
  String? buyerId;

  final _db = FirebaseFirestore.instance;

  PurchaseService(this.buyerId) {
    getPurchases();
  }

  Future<Map<String, dynamic>> addPurchase(Purchase purchaseModel) async {
    try {
      isLoading = true;
      notifyListeners();

      DocumentReference docRef = await _db.collection('purchases').add(purchaseModel.toJson());
      DocumentSnapshot docSnapshot = await docRef.get();
      Purchase purchase = Purchase.fromJson({
        'id': docSnapshot.id,
        ...docSnapshot.data() as Map<String, dynamic>
      });

      purchases.add(purchase);

      isLoading = false;
      notifyListeners();
      return {'success': true, 'message': 'Compra realizada exitosamente', 'data': purchase};

    } catch (e) {

      print('ERROR');
      print(e);
      isLoading = false;
      notifyListeners();

      return {'success': false, 'message': 'Error al realizar la compra', 'error': e};
    }
  }

  Future<void> getPurchases() async {
    try {
      isLoading = true;
      notifyListeners();

      QuerySnapshot query = await _db.collection('purchases')
      .where('buyerId', isEqualTo: buyerId)
      .get();
      purchases.clear();

      purchases.addAll(query.docs.map((doc) => Purchase.fromJson({
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>
      })).toList());

      isLoading = false;
      notifyListeners();
    } catch (e) {
      print('ERROR getPurchases');
      print(e);
      isLoading = false;
      notifyListeners();
    }
  }

}