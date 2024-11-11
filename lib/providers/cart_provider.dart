import 'package:flutter/material.dart';
import 'package:sistema_cursos_front/models/courses_model.dart';

class CartProvider extends ChangeNotifier {

  final List<Course> _coursesCart = [];

  List<Course> get coursesCart => _coursesCart;

  void addCourseToCart(Course course) {
    _coursesCart.add(course);
    notifyListeners();
  }

  void removeCourseFromCart(int index) {
    _coursesCart.removeAt(index);
    notifyListeners();
  }

  double getTotal() {
    return _coursesCart.fold(0, (sum, item) => sum + item.price);
  }

  bool isTheElementInCart(Course course) {
    return _coursesCart.any((element) => element.id == course.id);
  }

  void reset() {
    _coursesCart.clear();
  }

}