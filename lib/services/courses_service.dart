import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sistema_cursos_front/models/courses_model.dart';

class CoursesService extends ChangeNotifier {
  bool isLoading = false;

  final List<Course> courses = [];
  Course? _selectedCourse;

  final _db = FirebaseFirestore.instance;

  CoursesService() {
    getCourses();
  }

  Future<Map<String, dynamic>> getCourses() async {
    try {
      isLoading = true;
      notifyListeners();

      QuerySnapshot querySnapshot = await _db.collection('courses').get();
      List<Course> courses = querySnapshot.docs.map((doc) => Course.fromJson({
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>
      })).toList();

      isLoading = false;
      notifyListeners();
      return {'success': true, 'message': 'Cursos obtenidos exitosamente', 'data': courses};

    } catch(e) {
      return {'success': false, 'message': 'Error al obtener cursos', 'error': e};
    }
  }

  Future<Map<String, dynamic>> addCourse(Course course) async {
    try {
      isLoading = true;
      notifyListeners();

      DocumentReference docRef = await _db.collection('courses').add(course.toJson());
      DocumentSnapshot docSnapshot = await docRef.get();
      Course courseData = Course.fromJson({
        'id': docSnapshot.id,
        ...docSnapshot.data() as Map<String, dynamic>
      });

      isLoading = false;
      notifyListeners();
      return {'success': true, 'message': 'Curso agregado exitosamente', 'data': courseData};

    } catch(e) {
      isLoading = false;
      notifyListeners();
      return {'success': false, 'message': 'Error al agregar curso', 'error': e};
    }
  }

  Future<Map<String, dynamic>> updateCourse(Course course) async {
    try {
      isLoading = true;
      notifyListeners();

      await _db.collection('courses').doc(course.id).update(course.toJson());

      isLoading = false;
      notifyListeners();
      return {'success': true, 'message': 'Curso actualizado exitosamente'};

    } catch(e) {
      isLoading = false;
      notifyListeners();
      return {'success': false, 'message': 'Error al actualizar curso', 'error': e};
    }
  }

  Future<Map<String, dynamic>> deleteCourse(String id) async {
    try {
      isLoading = true;
      notifyListeners();

      await _db.collection('courses').doc(id).delete();

      isLoading = false;
      notifyListeners();
      return {'success': true, 'message': 'Curso eliminado exitosamente'};

    } catch(e) {
      isLoading = false;
      notifyListeners();
      return {'success': false, 'message': 'Error al eliminar curso', 'error': e};
    }
  }
  
  Course? get selectedCourse => _selectedCourse;
  set selectedCourse(Course? course) {
    _selectedCourse = course;
    notifyListeners();
  }

  Course get getEmptyCourse => Course(
    name: '',
    description: '',
    price: 0,
    timeDuration: const Duration(minutes: 0),
    image: '',
    author: '',
    language: '',
    numberOfLessons: 0
  );
}