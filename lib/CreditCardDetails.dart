import 'dart:io';

class CreditCardDetails {
  int? id;
  String cardNumber;
  String securityCode;
  String expirationDate;
  String userName;
  String birthDate;

  CreditCardDetails({
    this.id,
    required this.cardNumber,
    required this.securityCode,
    required this.expirationDate,
    required this.userName,
    required this.birthDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'card_number': cardNumber,
      'security_code': securityCode,
      'expiration_date': expirationDate,
      'user_name': userName,
      'birth_date': birthDate,
    };
  }

  factory CreditCardDetails.fromMap(Map<String, dynamic> map) {
    return CreditCardDetails(
      id: map['id'],
      cardNumber: map['card_number'],
      securityCode: map['security_code'],
      expirationDate: map['expiration_date'],
      userName: map['user_name'],
      birthDate: map['birth_date'],
    );
  }
}