import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../theme/app_theme.dart';
import '../providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  const TransactionItem(this.transaction, {super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context, listen: false);

    return Dismissible(
      key: Key(transaction.id),
      direction: DismissDirection.endToStart, // Vuốt từ phải sang trái để xóa giao dịch
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(24),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Xóa giao dịch?"),
            content: Text("Bạn có chắc muốn xóa giao dịch ${transaction.category}?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Hủy"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text("Xóa"),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        provider.deleteTransaction(transaction.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Đã xóa ${transaction.category}"),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: transaction.type == TransactionType.income
                    ? AppTheme.primary.withOpacity(0.1)
                    : const Color(0xFFF5FBF5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(transaction.icon, color: transaction.color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.category,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    transaction.formattedDate,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Text(
              transaction.formattedAmount,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: transaction.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}