import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../models/transaction.dart';

class ExpenseCard extends StatelessWidget {
  final Transaction transaction;

  const ExpenseCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getCategoryIcon(transaction.category),
              color: AppColors.accent,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: AppTextStyles.titleLarge.copyWith(fontSize: 18),
                ),
                Text(
                  DateFormat.yMMMd().format(transaction.date),
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
          ),
          Text(
            '-\$${transaction.amount.toStringAsFixed(2)}',
            style: AppTextStyles.headlineLarge.copyWith(
              fontSize: 20,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(Category category) {
    switch (category) {
      case Category.food:
        return Icons.fastfood_rounded;
      case Category.travel:
        return Icons.directions_car_rounded;
      case Category.shopping:
        return Icons.shopping_bag_rounded;
      case Category.bills:
        return Icons.receipt_long_rounded;
      case Category.entertainment:
        return Icons.movie_creation_rounded;
      case Category.other:
        return Icons.category_rounded;
    }
  }
}
