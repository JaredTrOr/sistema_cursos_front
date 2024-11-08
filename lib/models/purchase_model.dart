class Purchase {
  
  String? id;
  String purchasedCourseId;
  DateTime purchaseDate;
  String buyerId;

  Purchase({
    this.id,
    required this.purchasedCourseId,
    required this.purchaseDate,
    required this.buyerId
  });

  Map<String, dynamic> toJson() {
    return {
      "purchasedCourseId": purchasedCourseId,
      "purchaseDate": purchaseDate,
      "buyerId": buyerId
    };
  }

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      id: json['id'],
      purchasedCourseId: json['purchasedCourseId'],
      purchaseDate: json['purchaseDate'].toDate(),
      buyerId: json['buyerId']
    );
  }

}