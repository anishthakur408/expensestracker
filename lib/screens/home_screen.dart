import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/transaction.dart';
import '../widgets/expense_card.dart';
import 'add_expense.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Transaction> _registeredExpenses = [
    Transaction(
      title: 'Groceries',
      amount: 45.99,
      date: DateTime.now(),
      category: Category.food,
    ),
    Transaction(
      title: 'Netflix Subscription',
      amount: 14.99,
      date: DateTime.now().subtract(const Duration(days: 2)),
      category: Category.entertainment,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:
          Colors.transparent, // Important for custom rounded styling in child
      builder: (ctx) => AddExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Transaction expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Transaction expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Expense deleted.',
          style: TextStyle(
            color: AppColors.background,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: AppColors.accent,
        action: SnackBarAction(
          label: 'Undo',
          textColor: AppColors.background,
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  double get _totalExpenses {
    double sum = 0;
    for (final expense in _registeredExpenses) {
      sum += expense.amount;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Widget mainContent = Center(
      child: Text(
        'No expenses found. Start adding some!',
        style: AppTextStyles.bodyLarge,
      ),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ListView.builder(
        itemCount: _registeredExpenses.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(_registeredExpenses[index].id),
          background: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.error.withAlpha(230),
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white, size: 30),
          ),
          onDismissed: (direction) {
            _removeExpense(_registeredExpenses[index]);
          },
          child: ExpenseCard(transaction: _registeredExpenses[index]),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Header / Balance Section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 10,
              ),
              child: Column(
                children: [
                  Text('Total Balance', style: AppTextStyles.bodyMedium),
                  const SizedBox(height: 8),
                  Text(
                    '\$${(1000 - _totalExpenses).toStringAsFixed(2)}', // Mock initial budget of 1000
                    style: AppTextStyles.mainBalance,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.accent.withAlpha(51)),
                    ),
                    child: Text(
                      'Spent: \$${_totalExpenses.toStringAsFixed(2)}',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Optional: visual separator or chart placeholder
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: AppColors.background),
                child: mainContent,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddExpenseOverlay,
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.background,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth > 600 ? 24 : 18)),
        child: Icon(Icons.add, size: screenWidth > 600 ? 36 : 30),
      ),
    );
  }
}
