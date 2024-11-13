class PaymentModel {
  String? id;
  String cardType;
  String cardNumber;
  String cardHolder;
  String expirationDate;
  String cvv;
  String ownerId;

  PaymentModel({
    this.id,
    required this.cardType,
    required this.cardNumber,
    required this.cardHolder,
    required this.expirationDate,
    required this.cvv,
    required this.ownerId
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    id: json['id'],
    cardType: json['cardType'],
    cardNumber: json['cardNumber'],
    cardHolder: json['cardHolder'],
    expirationDate: json['expirationDate'],
    cvv: json['cvv'],
    ownerId: json['ownerId']
  );

  Map<String, dynamic> toJson() => {
    'cardType': cardType,
    'cardNumber': cardNumber,
    'cardHolder': cardHolder,
    'expirationDate': expirationDate,
    'cvv': cvv,
    'ownerId': ownerId
  };
}