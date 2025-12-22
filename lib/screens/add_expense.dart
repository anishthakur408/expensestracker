import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../models/transaction.dart';

class AddExpense extends StatefulWidget {
  final void Function(Transaction) onAddExpense;

  const AddExpense({super.key, required this.onAddExpense});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final oneYearAgo = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: oneYearAgo,
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.accent,
              onPrimary: AppColors.background,
              surface: AppColors.surface,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text(
            'Invalid Input',
            style: AppTextStyles.headlineLarge.copyWith(fontSize: 24),
          ),
          content: Text(
            'Please make sure a valid title, amount, date and category was entered.',
            style: AppTextStyles.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text(
                'Okay',
                style: TextStyle(color: AppColors.accent),
              ),
            ),
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(
      Transaction(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Add Expense', style: AppTextStyles.headlineLarge),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 32),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            style: AppTextStyles.displayLarge,
            decoration: InputDecoration(
              prefixText: '\$ ',
              prefixStyle: AppTextStyles.displayLarge.copyWith(
                color: AppColors.textSecondary,
              ),
              border: InputBorder.none,
              hintText: '0.00',
              hintStyle: AppTextStyles.displayLarge.copyWith(
                color: AppColors.surface,
              ),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _titleController,
            maxLength: 50,
            style: AppTextStyles.titleLarge,
            decoration: InputDecoration(
              label: Text('Title', style: AppTextStyles.bodyMedium),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.textSecondary),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.accent),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No Date Selected'
                          : DateFormat.yMMMd().format(_selectedDate!),
                      style: AppTextStyles.bodyMedium,
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              DropdownButton<Category>(
                value: _selectedCategory,
                dropdownColor: AppColors.surface,
                style: AppTextStyles.bodyMedium,
                underline: Container(height: 2, color: AppColors.accent),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.accent,
                ),
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: screenWidth > 600 ? 70 : 60,
            child: ElevatedButton(
              onPressed: _submitExpenseData,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth > 600 ? 20 : 16),
                ),
              ),
              child: Text(
                'Save Expense',
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.background,
                  fontSize: screenWidth > 600 ? 24 : 22,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
