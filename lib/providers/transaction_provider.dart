import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../data/dummy_transactions.dart';

class TransactionProvider extends ChangeNotifier {
  List<Transaction> _transactions = List.from(dummyTransactions);

  List<Transaction> get transactions => _transactions;

  double get totalBalance => _transactions.fold(
    0,
        (sum, t) => sum + (t.type == TransactionType.income ? t.amount : -t.amount),
  );

  double get totalIncome => _transactions
      .where((t) => t.type == TransactionType.income)
      .fold(0, (sum, t) => sum + t.amount);

  double get totalExpense => _transactions
      .where((t) => t.type == TransactionType.expense)
      .fold(0, (sum, t) => sum + t.amount);

  void addTransaction(Transaction transaction) {
    _transactions.insert(0, transaction);
    notifyListeners();
  }
}

// import 'package:flutter/material.dart';
// import '../models/transaction.dart';
// import '../data/dummy_transactions.dart';
//
// class TransactionProvider extends ChangeNotifier {
//   final List<Transaction> _transactions = List.from(dummyTransactions);
//
//   List<Transaction> get transactions => _transactions;
//
//   double get totalBalance => _transactions.fold(0, (sum, t) => sum + (t.type == TransactionType.income ? t.amount : -t.amount));
//
//   double get totalIncome => _transactions.where((t) => t.type == TransactionType.income).fold(0, (sum, t) => sum + t.amount);
//
//   double get totalExpense => _transactions.where((t) => t.type == TransactionType.expense).fold(0, (sum, t) => sum + t.amount);
//
//   void addTransaction(Transaction transaction) {
//     _transactions.insert(0, transaction);
//     notifyListeners();
//   }
// }