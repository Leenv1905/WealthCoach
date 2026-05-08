import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../repositories/transaction_repository.dart';

class TransactionProvider extends ChangeNotifier {
  final TransactionRepository _repository = TransactionRepository();
  List<Transaction> _transactions = [];

  // Lọc theo tháng
  DateTime _currentFilterMonth = DateTime.now();

  List<Transaction> get transactions => _transactions;

  DateTime get currentFilterMonth => _currentFilterMonth;

  void setFilterMonth(DateTime month) {
    _currentFilterMonth = DateTime(month.year, month.month);
    notifyListeners();
  }

  // Lấy danh sách theo tháng hiện tại
  List<Transaction> get filteredTransactions {
    return _transactions.where((t) {
      return t.date.year == _currentFilterMonth.year &&
          t.date.month == _currentFilterMonth.month;
    }).toList();
  }

  double get totalBalance {
    return filteredTransactions.fold(
      0,
          (sum, t) => sum + (t.type == TransactionType.income ? t.amount : -t.amount),
    );
  }

  double get totalIncome {
    return filteredTransactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get totalExpense {
    return filteredTransactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  Future<void> loadTransactions() async {
    _transactions = await _repository.getAll();
    notifyListeners();
  }

  Future<void> addTransaction(Transaction transaction) async {
    await _repository.add(transaction);
    _transactions.insert(0, transaction);
    notifyListeners();
  }

  Future<void> updateTransaction(Transaction updatedTransaction) async {
    await _repository.update(updatedTransaction);
    final index = _transactions.indexWhere((t) => t.id == updatedTransaction.id);
    if (index != -1) {
      _transactions[index] = updatedTransaction;
    }
    notifyListeners();
  }

  Future<void> deleteTransaction(String id) async {
    await _repository.delete(id);
    _transactions.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}
