import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'CreditCardDetails.dart';
import 'dart:io';

class SavedCardsScreen extends StatelessWidget {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cartões Salvos'),
      ),
      body: FutureBuilder<List<CreditCardDetails>>(
        future: databaseHelper.getAllCardDetails(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CreditCardDetails>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text('Nenhum cartão salvo.'),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                CreditCardDetails cardDetails = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    _navigateToCardDetails(context, cardDetails);
                  },
                  child: ListTile(
                    title: Text(cardDetails.cardNumber),
                    subtitle: Text(cardDetails.userName),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        databaseHelper.deleteCardDetails(cardDetails.id!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Cartão removido')),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar os dados do banco de dados.'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _navigateToCardDetails(BuildContext context, CreditCardDetails cardDetails) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardDetailsScreen(cardDetails: cardDetails),
      ),
    );
  }
}

class CardDetailsScreen extends StatelessWidget {
  final CreditCardDetails cardDetails;

  CardDetailsScreen({required this.cardDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Cartão'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Número do Cartão: ${cardDetails.cardNumber}'),
            Text('Código de Segurança: ${cardDetails.securityCode}'),
            Text('Data de Validade: ${cardDetails.expirationDate}'),
            Text('Nome do Usuário: ${cardDetails.userName}'),
            Text('Data de Nascimento: ${cardDetails.birthDate}'),
          ],
        ),
      ),
    );
  }
}