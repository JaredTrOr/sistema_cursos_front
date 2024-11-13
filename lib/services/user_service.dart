import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sistema_cursos_front/models/user_model.dart';

class UserService extends ChangeNotifier {

  bool isLoading = false;
  User? _userProvider;

  final _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> signup(User user) async {
    try {
      isLoading = true;
      notifyListeners();

       
      QuerySnapshot existingUser = await _db.collection('users')
      .where('email', isEqualTo: user.email)
      .get();

      if (existingUser.docs.isNotEmpty) {
        isLoading = false;
        notifyListeners();
        return {'success': false, 'message': 'El correo ya está registrado'};
      }
      
      DocumentReference docRef = await _db.collection('users').add(user.toJson());
      DocumentSnapshot docSnapshot = await docRef.get();
      User userData = User.fromJson({
        'id': docSnapshot.id,
        ...docSnapshot.data() as Map<String, dynamic>
      });

      isLoading = false;
      notifyListeners();
      return {'success': true, 'message': 'Usuario registrado exitosamente', 'data': userData};

    } catch (e) {
      isLoading = false;
      notifyListeners();
      return {'success': false, 'message': 'Error al registrar usuario', 'error': e};
    }

  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();
      
      QuerySnapshot query = await _db.collection('users')
      .where('email', isEqualTo: email)
      .where('password', isEqualTo: password)
      .get();

      if (query.docs.isEmpty) {
        isLoading = false;
        notifyListeners();
        return {'success': false, 'message': 'Usuario o contraseña incorrectos'};
      }

      DocumentSnapshot userDoc = query.docs.first;
      User userData = User.fromJson({
        'id': userDoc.id,
        ...userDoc.data() as Map<String, dynamic>
      });

      isLoading = false;
      notifyListeners();

      return {'success': true, 'message': 'Inicio de sesión exitoso', 'data': userData};
      
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return {'success': false, 'message': 'Error al registrar usuario'};
    }
  }

  Future<Map<String, dynamic>> updateUser(User user) async {
    try {
      isLoading = true;
      notifyListeners();

      await _db.collection('users').doc(user.id).update(user.toJson());
      userProvider = user;

      isLoading = false;
      notifyListeners();

      return {'success': true, 'message': 'Usuario actualizado exitosamente'};
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return {'success': false, 'message': 'Error al actualizar usuario'};
    }
  }

  Future<Map<String, dynamic>> deleteUser(String userId) async {
    try {
      isLoading = true;
      notifyListeners();

      await _db.collection('users').doc(userId).delete();

      isLoading = false;
      notifyListeners();
      return {'success': true, 'message': 'Usuario eliminado exitosamente'};
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return {'success': false, 'message': 'Error al eliminar usuario'};
    }
  }

  // Manejo de cursos favoritos
  Future<void> addFavoriteCourse(String id) async {
    try {
      isLoading = true;
      notifyListeners();

      userProvider.favoriteCourses.add(id);
      await _db.collection('users').doc(userProvider.id).update({
        'favoriteCourses': userProvider.favoriteCourses
      });

      isLoading = false;
      notifyListeners();
    } catch(e) {
      isLoading = false;
      notifyListeners();
      print('Error al agregar curso favorito');
      print(e);
    }
    
  }

  Future<void> removeFavoriteCourse(String id) async {

    try {
      isLoading = true;
      notifyListeners();

      userProvider.favoriteCourses.remove(id);
      await _db.collection('users').doc(userProvider.id).update({
        'favoriteCourses': userProvider.favoriteCourses
      });

      isLoading = false;
      notifyListeners();
    } catch(e) {
      isLoading = false;
      notifyListeners();
      print('Error al eliminar curso favorito');
      print(e);
    }
  }

  addNewPurchasedCourses(List<String> purchasedCourses) async {
    try {
      isLoading = true;
      notifyListeners();

      userProvider.courses.addAll(purchasedCourses);
      await _db.collection('users').doc(userProvider.id).update({
        'courses': userProvider.courses
      });

      isLoading = false;
      notifyListeners();
    } catch(e) {
      isLoading = false;
      notifyListeners();
      print('Error al agregar cursos comprados');
      print(e);
    }
  }

  bool isFavoriteCourse(String id) {
    return userProvider.favoriteCourses.contains(id);
  }

  // Setter and getter of user provider
  User get userProvider => _userProvider!;

  User get getEmptyUser => User(email: '', password: '', name: '', rol: 0, courses: [], image: '', favoriteCourses: []);

  List<String> get getUserFavoriteCourses => _userProvider!.favoriteCourses;
  
  set userProvider(User user) {
    _userProvider = user;
    notifyListeners();
  }
}