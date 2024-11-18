
class Course{

  String? id;
  String name;
  String description;
  double price;
  String timeDuration;
  String? image;
  String author;
  String? authorId;
  String language;
  List<dynamic> lessons;
  int amountOfFavorites;

  Course({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.timeDuration,
    this.image,
    required this.author,
    required this.language,
    this.lessons = const[],
    this.amountOfFavorites = 0,
    this.authorId
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "timeDuration": timeDuration,
      "image": image,
      "author": author,
      "language": language,
      "lessons": lessons,
      "amountOfFavorites": amountOfFavorites,
      "authorId": authorId
    };
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      timeDuration: json['timeDuration'],
      image: json['image'],
      author: json['author'],
      language: json['language'],
      lessons: json['lessons'],
      amountOfFavorites: json['amountOfFavorites'],
      authorId: json['authorId']
    );

  }

}