import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/transaction_item.dart';
import '../theme/app_theme.dart';
import 'add_transaction_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thẻ Total Balance
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "TOTAL BALANCE",
                    style: TextStyle(color: Colors.white70, fontSize: 14, letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$${provider.totalBalance.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.trending_up, color: Colors.white, size: 18),
                        SizedBox(width: 6),
                        Text("+4.5% this month", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Thẻ Income & Expense
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

            ...provider.transactions.take(5).map((t) => TransactionItem(t)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: const Icon(Icons.add, size: 32),
      ),
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
              Icon(
                isIncome ? Icons.south : Icons.north,
                color: isIncome ? AppTheme.primary : AppTheme.secondary,
              ),
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