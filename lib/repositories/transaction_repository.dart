import 'package:hive_flutter/hive_flutter.dart';
import '../models/transaction.dart';

class TransactionRepository {
  static const String _boxName = 'transactions';

  Future<void> init() async {
    await Hive.openBox<Transaction>(_boxName);
  }

  Future<List<Transaction>> getAll() async {
    final box = Hive.box<Transaction>(_boxName);
    final list = box.values.toList();
    list.sort((a, b) => b.date.compareTo(a.date)); // Mới nhất lên trên
    return list;
  }

  Future<void> add(Transaction transaction) async {
    final box = Hive.box<Transaction>(_boxName);
    await box.put(transaction.id, transaction);
  }

  Future<void> delete(String id) async {
    final box = Hive.box<Transaction>(_boxName);
    await box.delete(id);
  }

  Future<void> clearAll() async {
    final box = Hive.box<Transaction>(_boxName);
    await box.clear();
  }
}