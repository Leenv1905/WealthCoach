import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';

enum TransactionType { income, expense }

class Transaction {
  final String id;
  final double amount;
  final TransactionType type;
  final String category;
  final DateTime date;
  final String note;
  final IconData icon;

  Transaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    this.note = '',
    required this.icon,
  });

  String get formattedAmount => type == TransactionType.income
      ? '+${amount.toStringAsFixed(2)}'
      : '-${amount.toStringAsFixed(2)}';

  Color get color => type == TransactionType.income ? AppTheme.primary : AppTheme.secondary;

  String get formattedDate => DateFormat('MMM d, yyyy').format(date);
}