import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../repositories/transaction_repository.dart';

class TransactionProvider extends ChangeNotifier {
  final TransactionRepository _repository = TransactionRepository();
  List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  double get totalBalance => _transactions.fold(
    0,
        (sum, t) => sum + (t.type == TransactionType.income ? t.amount : -t.amount),
  );

  double get totalIncome => _transactions
      .where((t) => t.type == TransactionType.income)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get totalExpense => _transactions
      .where((t) => t.type == TransactionType.expense)
      .fold(0.0, (sum, t) => sum + t.amount);

  Future<void> loadTransactions() async {
    _transactions = await _repository.getAll();
    notifyListeners();
  }

  Future<void> addTransaction(Transaction transaction) async {
    await _repository.add(transaction);
    _transactions.insert(0, transaction);
    notifyListeners();
  }

  Future<void> deleteTransaction(String id) async {
    await _repository.delete(id);
    _transactions.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}