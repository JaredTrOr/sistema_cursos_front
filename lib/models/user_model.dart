class User {

  String? id;
  String email;
  String password;
  String name;
  int rol = 0;
  List<String> favoriteCourses;
  List<String> courses;
  String? image;

  User({
    this.id,
    required this.email,
    required this.password,
    required this.name,
    this.rol = 0,
    this.courses = const [],
    this.favoriteCourses = const [],
    this.image = ''
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "name": name,
      "rol": rol,
      "courses": courses,
      "favoriteCourses": favoriteCourses,
      "image": image
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      rol: json['rol'],
      courses: List<String>.from(json['courses']),
      favoriteCourses: List<String>.from(json['favoriteCourses']),
      image: json['imagen']
    );
  }

}