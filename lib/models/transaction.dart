import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final TransactionType type;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final DateTime date;

  @HiveField(5)
  final String note;

  @HiveField(6)
  final int iconCode;

  Transaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    this.note = '',
    required this.iconCode,
  });
  // Getter để lấy IconData từ iconCode
  IconData get icon => IconData(iconCode, fontFamily: 'MaterialIcons');

  String get formattedAmount => type == TransactionType.income
      ? '+${amount.toStringAsFixed(2)}'
      : '-${amount.toStringAsFixed(2)}';

  Color get color => type == TransactionType.income ? AppTheme.primary : AppTheme.secondary;

  String get formattedDate => DateFormat('MMM d, yyyy').format(date);
}

@HiveType(typeId: 1)
enum TransactionType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}