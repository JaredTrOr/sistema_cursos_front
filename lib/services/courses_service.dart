import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sistema_cursos_front/models/courses_model.dart';
import 'dart:convert';

class CoursesService extends ChangeNotifier {
  bool isLoading = false;

  List<Course> courses = [];
  Course? _selectedCourse;
  File? courseImage;

  final _db = FirebaseFirestore.instance;

  CoursesService({ String? authorId }) {
    if (authorId != null) {
      getCoursesByAuthorId(authorId);
      return;
    } 
    getCourses();
  }

  Future<void> getCourses() async {
    try {
      isLoading = true;
      notifyListeners();

      QuerySnapshot querySnapshot = await _db.collection('courses').get();
      courses.clear();
      courses.addAll(querySnapshot.docs.map((doc) => Course.fromJson({
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>
      })).toList());

      isLoading = false;
      notifyListeners();

    } catch(e) {
      print('ERROR getCourses');
      print(e);
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getCoursesByAuthorId(String id) async {
    try {
      isLoading = true;
      notifyListeners(); 

      QuerySnapshot querySnapshot = await _db.collection('courses').where('authorId', isEqualTo: id).get();
      courses.clear();
      courses.addAll(querySnapshot.docs.map((doc) => Course.fromJson({
        'id': doc.id,
        ...doc.data() as Map<String, dynamic>
      })).toList());

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print('ERROR getCoursesByAuthorId');
      print(e);
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
      courses.add(courseData);

      isLoading = false;
      notifyListeners();
      return {'success': true, 'message': 'Curso agregado exitosamente', 'data': courseData};

    } catch(e) {
      print('Error addCourse');
      print(e);
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
      //Update the course in the list
      courses = courses.map((c) => c.id == course.id ? course : c).toList();

      isLoading = false;
      notifyListeners();
      return {'success': true, 'message': 'Curso actualizado exitosamente'};

    } catch(e) {
      print('Error updateCourse');
      print(e);
      isLoading = false;
      notifyListeners();
      return {'success': false, 'message': 'Error al actualizar curso', 'error': e};
    }
  }

  Future<Map<String, dynamic>> deleteCourse(String id) async {
    try {
      isLoading = true;
      notifyListeners();

      // Check if the course has already been bought by a user
      QuerySnapshot querySnapshot = await _db.collection('users').where('courses', arrayContains: id).get();
      if (querySnapshot.docs.isNotEmpty) {
        isLoading = false;
        notifyListeners();
        return {'success': false, 'message': 'El curso ya ha sido adquirido por un usuario'};
      }
      
      await _db.collection('courses').doc(id).delete();
      courses.removeWhere((course) => course.id == id);

      isLoading = false;
      notifyListeners();
      return {'success': true, 'message': 'Curso eliminado exitosamente'};

    } catch(e) {
      print('Error deleteCourse');
      print(e);
      isLoading = false;
      notifyListeners();
      return {'success': false, 'message': 'Error al eliminar curso', 'error': e};
    }
  }
  
  Future<void> increaseAmountOfFavorites(Course course) async {
    try {
      course.amountOfFavorites = course.amountOfFavorites + 1;
      await _db.collection('courses').doc(course.id).update({
        'amountOfFavorites': course.amountOfFavorites
      });
    } catch(e) {
      print('ERROR increaseAmountOfFavorites');
      print(e);
    }
  }

  Future<void> decreaseAmountOfFavorites(Course course) async {
    try {
      course.amountOfFavorites = course.amountOfFavorites - 1;
      await _db.collection('courses').doc(course.id).update({
        'amountOfFavorites': course.amountOfFavorites
      });
    } catch(e) {
      print('ERROR decreaseAmountOfFavorites');
      print(e);
    }
  }

  Course getCourseById(String id) {
    return courses.firstWhere((course) => course.id == id);
  }

  List<Course> getCoursesById(List<String> idList) {
    return courses.where((course) => idList.contains(course.id)).toList();
  }

  bool isCoursePurchased(String courseId, List<String> userCourses) {
    return userCourses.contains(courseId);
  }
  
  void updateImage(String path) {
    _selectedCourse!.image = path;
    courseImage = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> subirImagen() async {

    const clodinaryUrl = 'https://api.cloudinary.com/v1_1/dwpkveemt/image/upload?upload_preset=image-storage';

    if (courseImage == null) return null;

    isLoading = true;
    notifyListeners();

    final url = Uri.parse(clodinaryUrl); // Url para cloudinary
    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', courseImage!.path);
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Error en la petición');
      return null;
    }

    courseImage = null;
    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];

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
    timeDuration: '',
    image: '',
    author: '',
    language: '',
    lessons: []
  );
}