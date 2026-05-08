import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/transaction.dart';
import '../providers/transaction_provider.dart';
import '../theme/app_theme.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _amountController = TextEditingController(text: "0.00");
  TransactionType _type = TransactionType.expense;
  String? _category;
  DateTime _selectedDate = DateTime.now();
  final _noteController = TextEditingController();

  final List<String> _categories = [
    'Ăn uống',
    'Lương',
    'Di chuyển',
    'Thuê nhà',
    'Cafe',
    'Mua sắm',
    'Xăng dầu',
    'Điện nước',
    'Khác'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Add New"),
        backgroundColor: AppTheme.background,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: NetworkImage("https://i.pravatar.cc/150?u=1"),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("AMOUNT", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text("\$", style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "0.00",
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Income / Expense Toggle
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildToggle(
                      "Income",
                      _type == TransactionType.income,
                          () => setState(() => _type = TransactionType.income),
                    ),
                  ),
                  Expanded(
                    child: _buildToggle(
                      "Expense",
                      _type == TransactionType.expense,
                          () => setState(() => _type = TransactionType.expense),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text("Category", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _category,
              hint: const Text("Select Category"),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
              items: _categories.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (value) => setState(() => _category = value),
            ),

            const SizedBox(height: 24),

            const Text("Transaction Date", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("${_selectedDate.month}/${_selectedDate.day}/${_selectedDate.year}"),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (date != null) setState(() => _selectedDate = date);
              },
            ),

            const SizedBox(height: 24),

            const Text("Note (Optional)", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _noteController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "What was this for?",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 24),

            // Wallet & Tax bản demo
            Row(
              children: [
                Expanded(child: _buildTag("Personal", Icons.wallet, Colors.green)),
                const SizedBox(width: 12),
                Expanded(child: _buildTag("Deductible", Icons.receipt_long, Colors.red)),
              ],
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _saveTransaction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text(
                  "Save Transaction",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggle(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(
                label == "Personal" ? "WALLET" : "TAX",
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _saveTransaction() {
    if (_category == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng chọn danh mục")),
      );
      return;
    }

    final amountText = _amountController.text.trim();
    if (amountText.isEmpty || double.tryParse(amountText) == null || double.parse(amountText) <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập số tiền hợp lệ")),
      );
      return;
    }

    final provider = Provider.of<TransactionProvider>(context, listen: false);

    final newTx = Transaction(
      id: const Uuid().v4(),
      amount: double.parse(amountText),
      type: _type,
      category: _category!,
      date: _selectedDate,
      note: _noteController.text,
      iconCode: _getIconForCategory(_category!).codePoint,
    );

    provider.addTransaction(newTx);
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Giao dịch đã được lưu!")),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'Ăn uống':
        return Icons.restaurant;
      case 'Lương':
        return Icons.payments;
      case 'Di chuyển':
        return Icons.directions_car;
      case 'Thuê nhà':
        return Icons.home;
      case 'Cafe':
        return Icons.coffee;
      case 'Mua sắm':
        return Icons.shopping_basket;
      case 'Xăng dầu':
        return Icons.local_gas_station;
      case 'Điện nước':
        return Icons.electric_bolt;
      default:
        return Icons.attach_money;
    }
  }
}