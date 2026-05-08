import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import '../providers/transaction_provider.dart';
import '../widgets/transaction_item.dart';
import '../theme/app_theme.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _filter = "All"; // All, Income, Expense

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    final now = DateTime.now();

    // Lọc theo Income/Expense
    var filtered = provider.transactions;
    if (_filter == "Income") {
      filtered = filtered.where((t) => t.type == TransactionType.income).toList();
    } else if (_filter == "Expense") {
      filtered = filtered.where((t) => t.type == TransactionType.expense).toList();
    }

    // Nhóm theo ngày
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final todayTx = filtered.where((t) => _isSameDay(t.date, today)).toList();
    final yesterdayTx = filtered.where((t) => _isSameDay(t.date, yesterday)).toList();
    final olderTx = filtered.where((t) =>
    !_isSameDay(t.date, today) && !_isSameDay(t.date, yesterday)).toList();

    // Monthly Outlook (tháng hiện tại)
    final monthlyBalance = _calculateMonthlyBalance(provider.transactions, now);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text("Transactions"),
        backgroundColor: AppTheme.background,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip("All", _filter == "All"),
                const SizedBox(width: 8),
                _buildFilterChip("Income", _filter == "Income"),
                const SizedBox(width: 8),
                _buildFilterChip("Expense", _filter == "Expense"),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Monthly Outlook
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("MONTHLY OUTLOOK",
                    style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 8),
                Text(
                  "\$${monthlyBalance.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.trending_up, color: Colors.white, size: 18),
                    SizedBox(width: 6),
                    Text("12% more than last month",
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Today
          if (todayTx.isNotEmpty) ...[
            const Text("TODAY", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...todayTx.map((t) => TransactionItem(t)),
            const SizedBox(height: 24),
          ],

          // Yesterday
          if (yesterdayTx.isNotEmpty) ...[
            const Text("YESTERDAY", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...yesterdayTx.map((t) => TransactionItem(t)),
            const SizedBox(height: 24),
          ],

          // Older
          if (olderTx.isNotEmpty) ...[
            const Text("OLDER", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...olderTx.map((t) => TransactionItem(t)),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: const Icon(Icons.add),
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  double _calculateMonthlyBalance(List<Transaction> transactions, DateTime now) {
    final startOfMonth = DateTime(now.year, now.month, 1);
    return transactions
        .where((t) => t.date.isAfter(startOfMonth.subtract(const Duration(days: 1))))
        .fold(0.0, (sum, t) => sum + (t.type == TransactionType.income ? t.amount : -t.amount));
  }

  Widget _buildFilterChip(String label, bool selected) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (value) => setState(() => _filter = label),
      backgroundColor: Colors.white,
      selectedColor: AppTheme.primary,
      labelStyle: TextStyle(color: selected ? Colors.white : Colors.black87),
      elevation: 1,
    );
  }
}
