import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../theme/app_theme.dart';
import 'category_icon.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  const TransactionItem(this.transaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          CategoryIcon(transaction),
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
    );
  }
}

// import 'package:flutter/material.dart';
// import '../models/transaction.dart';
// import '../theme/app_theme.dart';
//
// class TransactionItem extends StatelessWidget {
//   final Transaction transaction;
//   const TransactionItem(this.transaction, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 20,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//               color: transaction.type == TransactionType.income
//                   ? AppTheme.primary.withOpacity(0.1)
//                   : const Color(0xFFF5FBF5),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Icon(transaction.icon, color: transaction.color, size: 28),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   transaction.category,
//                   style: Theme.of(context).textTheme.titleMedium,
//                 ),
//                 Text(
//                   transaction.formattedDate,
//                   style: Theme.of(context).textTheme.bodySmall,
//                 ),
//               ],
//             ),
//           ),
//           Text(
//             transaction.formattedAmount,
//             style: TextStyle(
//               fontSize: 17,
//               fontWeight: FontWeight.w600,
//               color: transaction.color,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }