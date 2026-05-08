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
  String _typeFilter = "All"; // All, Income, Expense

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);

    // Lọc theo loại (Income/Expense)
    var filtered = provider.filteredTransactions;
    if (_typeFilter == "Income") {
      filtered = filtered.where((t) => t.type == TransactionType.income).toList();
    } else if (_typeFilter == "Expense") {
      filtered = filtered.where((t) => t.type == TransactionType.expense).toList();
    }

    // Nhóm theo ngày
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final todayTx = filtered.where((t) => _isSameDay(t.date, today)).toList();
    final yesterdayTx = filtered.where((t) => _isSameDay(t.date, yesterday)).toList();
    final olderTx = filtered.where((t) =>
    !_isSameDay(t.date, today) && !_isSameDay(t.date, yesterday)).toList();

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
          // Lọc theo tháng
          _buildMonthFilter(context, provider),

          const SizedBox(height: 16),

          // Loại giao dịch
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildTypeChip("All", _typeFilter == "All"),
                const SizedBox(width: 8),
                _buildTypeChip("Income", _typeFilter == "Income"),
                const SizedBox(width: 8),
                _buildTypeChip("Expense", _typeFilter == "Expense"),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Monthly Outlook, phần này cần cải thiện để thể hiện dữ liệu trực quan hơn
          _buildMonthlyOutlook(provider),

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

  // ==================== MONTH FILTER ====================
  Widget _buildMonthFilter(BuildContext context, TransactionProvider provider) {
    final monthFormat = DateFormat('MMMM yyyy');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          monthFormat.format(provider.currentFilterMonth),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                final newMonth = DateTime(
                  provider.currentFilterMonth.year,
                  provider.currentFilterMonth.month - 1,
                );
                provider.setFilterMonth(newMonth);
              },
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () {
                final newMonth = DateTime(
                  provider.currentFilterMonth.year,
                  provider.currentFilterMonth.month + 1,
                );
                provider.setFilterMonth(newMonth);
              },
            ),
          ],
        ),
      ],
    );
  }

  // ==================== TYPE FILTER ====================
  Widget _buildTypeChip(String label, bool selected) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (value) => setState(() => _typeFilter = label),
      backgroundColor: Colors.white,
      selectedColor: AppTheme.primary,
      labelStyle: TextStyle(color: selected ? Colors.white : Colors.black87),
      elevation: 1,
    );
  }

  // ==================== MONTHLY OUTLOOK ====================
  Widget _buildMonthlyOutlook(TransactionProvider provider) {
    return Container(
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
            "\$${provider.totalBalance.toStringAsFixed(2)}",
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
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}