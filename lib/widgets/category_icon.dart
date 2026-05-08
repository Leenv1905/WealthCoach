import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../theme/app_theme.dart';

class CategoryIcon extends StatelessWidget {
  final Transaction transaction;
  const CategoryIcon(this.transaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: transaction.type == TransactionType.income
            ? AppTheme.primary.withOpacity(0.1)
            : const Color(0xFFF5FBF5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        transaction.icon,
        color: transaction.color,
        size: 28,
      ),
    );
  }
}