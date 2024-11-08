
class Course{

  String? id;
  String name;
  String description;
  double price;
  Duration timeDuration;
  String? image;
  String author;
  String language;
  int numberOfLessons;

  Course({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.timeDuration,
    this.image,
    required this.author,
    required this.language,
    required this.numberOfLessons
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "timeDuration": timeDuration.inMinutes,
      "image": image,
      "author": author,
      "language": language,
      "numberOfLessons": numberOfLessons
    };
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      timeDuration: Duration(minutes: json['timeDuration']),
      image: json['image'],
      author: json['author'],
      language: json['language'],
      numberOfLessons: json['numberOfLessons']
    );

  }

}