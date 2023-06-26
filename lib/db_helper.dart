import 'dart:async';
import 'dart:io';


import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled5/CreditCardDetails.dart';
import 'CreditCardDetails.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'credit_card.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE credit_cards (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      card_number TEXT,
      security_code TEXT,
      expiration_date TEXT,
      user_name TEXT,
      birth_date TEXT
    )
    ''');
  }

  Future<int> insertCardDetails(CreditCardDetails cardDetails) async {
    final db = await database;
    return await db!.insert('credit_cards', cardDetails.toMap());
  }

  Future<List<CreditCardDetails>> getAllCardDetails() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('credit_cards');
    return List.generate(maps.length, (index) {
      return CreditCardDetails.fromMap(maps[index]);
    });
  }

  Future<void> deleteCardDetails(int id) async {
    final db = await database;
    await db!.delete(
      'credit_cards',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}