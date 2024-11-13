class Purchase {
  
  String? id;
  List<String> purchasedCoursesId;
  DateTime purchaseDate;
  String buyerId;
  double total;

  Purchase({
    this.id,
    required this.purchasedCoursesId,
    required this.purchaseDate,
    required this.buyerId,
    required this.total
  });

  Map<String, dynamic> toJson() {
    return {
      "purchasedCoursesId": purchasedCoursesId,
      "purchaseDate": purchaseDate,
      "buyerId": buyerId,
      'total': total
    };
  }

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      id: json['id'],
      purchasedCoursesId: List<String>.from(json['purchasedCoursesId']),
      purchaseDate: json['purchaseDate'].toDate(),
      buyerId: json['buyerId'],
      total: json['total']
    );
  }

}