import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../theme/app_theme.dart';
import '../providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import '../screens/add_transaction_screen.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  const TransactionItem(this.transaction, {super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context, listen: false);

    return Dismissible(
      key: Key(transaction.id),
      direction: DismissDirection.horizontal,

      // Vuốt sang trái = Xóa
      background: _buildDismissBackground(Colors.red, Icons.delete, Alignment.centerRight),

      // Vuốt sang phải = Chỉnh sửa
      secondaryBackground: _buildDismissBackground(Colors.blue, Icons.edit, Alignment.centerLeft),

      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          // Xóa
          return await _showDeleteConfirm(context);
        } else {
          // Chỉnh sửa
          _navigateToEdit(context);
          return false; // Không dismiss khi edit
        }
      },

      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          provider.deleteTransaction(transaction.id);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Đã xóa ${transaction.category}")),
          );
        }
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 4)),
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
                  Text(transaction.category, style: Theme.of(context).textTheme.titleMedium),
                  Text(transaction.formattedDate, style: Theme.of(context).textTheme.bodySmall),
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

  Widget _buildDismissBackground(Color color, IconData icon, Alignment alignment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Icon(icon, color: Colors.white),
    );
  }

  Future<bool> _showDeleteConfirm(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Xóa giao dịch?"),
        content: Text("Bạn có chắc muốn xóa '${transaction.category}'?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Hủy")),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Xóa"),
          ),
        ],
      ),
    ) ?? false;
  }

  void _navigateToEdit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTransactionScreen(transactionToEdit: transaction),
      ),
    );
  }
}