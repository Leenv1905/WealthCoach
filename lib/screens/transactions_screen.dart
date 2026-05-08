import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  String _filter = "All"; // All, Income, Expense, All được đặt mặc định

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    var filtered = provider.transactions;

    if (_filter == "Income") {
      filtered = filtered.where((t) => t.type == TransactionType.income).toList();
    } else if (_filter == "Expense") {
      filtered = filtered.where((t) => t.type == TransactionType.expense).toList();
    }

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
          // Filter
          Row(
            children: [
              _buildFilterChip("All", _filter == "All"),
              const SizedBox(width: 8),
              _buildFilterChip("Income", _filter == "Income"),
              const SizedBox(width: 8),
              _buildFilterChip("Expense", _filter == "Expense"),
            ],
          ),

          const SizedBox(height: 24),

          // Chi teu hàng tháng
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("MONTHLY OUTLOOK", style: TextStyle(color: Colors.white70, fontSize: 14)),
                SizedBox(height: 8),
                Text("\$5,420.00", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.trending_up, color: Colors.white, size: 18),
                    SizedBox(width: 6),
                    Text("12% more than last month", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Danh sách giao dịch gần đây chia theo ngày
          const Text("TODAY", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ...filtered.take(2).map((t) => TransactionItem(t)),

          const SizedBox(height: 24),
          const Text("YESTERDAY", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ...filtered.skip(2).map((t) => TransactionItem(t)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool selected) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (bool value) {
        setState(() => _filter = label);
      },
      backgroundColor: Colors.white,
      selectedColor: AppTheme.primary,
      labelStyle: TextStyle(color: selected ? Colors.white : Colors.black87),
    );
  }
}