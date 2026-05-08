import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/transaction_provider.dart';
import '../widgets/balance_card.dart';
import '../widgets/transaction_item.dart';
import '../theme/app_theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bộ lọc tháng
            _buildMonthFilter(context, provider),

            const SizedBox(height: 16),

            // Total Balance Card
            const BalanceCard(),
            const SizedBox(height: 24),

            // Income & Expense
            Row(
              children: [
                Expanded(child: _buildStatCard(context, "Income", provider.totalIncome, true)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard(context, "Expense", provider.totalExpense, false)),
              ],
            ),

            const SizedBox(height: 32),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Recent Transactions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/transactions'),
                  child: const Text("View All"),
                ),
              ],
            ),

            ...provider.filteredTransactions.take(5).map((tx) => TransactionItem(tx)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }

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

  Widget _buildStatCard(BuildContext context, String title, double amount, bool isIncome) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(isIncome ? Icons.south : Icons.north,
                  color: isIncome ? AppTheme.primary : AppTheme.secondary),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "\$${amount.toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: isIncome ? AppTheme.primary : AppTheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}