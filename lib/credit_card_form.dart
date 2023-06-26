import 'package:flutter/material.dart';
import 'SavedCardsScreen.dart';
import 'RandomImageScreen.dart';
import 'db_helper.dart';
import 'package:untitled5/CreditCardDetails.dart';
import 'dart:io';

class CreditCardForm extends StatefulWidget {
  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController securityCodeController = TextEditingController();
  TextEditingController expirationDateController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  DatabaseHelper databaseHelper = DatabaseHelper();

  void _saveCardDetails() async {
    CreditCardDetails cardDetails = CreditCardDetails(
      cardNumber: cardNumberController.text,
      securityCode: securityCodeController.text,
      expirationDate: expirationDateController.text,
      userName: userNameController.text,
      birthDate: birthDateController.text,
    );

    int result = await databaseHelper.insertCardDetails(cardDetails);

    if (result != 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Dados do cartão salvos com sucesso')),
      );


      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao salvar os dados do cartão')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Descubra qual personagem \nde anime é você'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Número do cartão de crédito'),
              TextField(
                controller: cardNumberController,
              ),
              SizedBox(height: 16.0),
              Text('Código de Segurança'),
              TextField(
                controller: securityCodeController,
              ),
              SizedBox(height: 16.0),
              Text('Data de Validade'),
              TextField(
                controller: expirationDateController,
              ),
              SizedBox(height: 16.0),
              Text('Nome do Usuário'),
              TextField(
                controller: userNameController,
              ),
              SizedBox(height: 16.0),
              Text('Data de Nascimento'),
              TextField(
                controller: birthDateController,
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _saveCardDetails,
                    child: Text('Salvar'),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SavedCardsScreen(),
                        ),
                      );
                    },
                    child: Text('Ver Cartões Salvos'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}