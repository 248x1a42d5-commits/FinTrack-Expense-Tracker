import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/services/expense_provider.dart';
import 'package:flutter_application_1/screens/home_screen.dart';

void main() {
  testWidgets('Home Screen shows empty state text', (WidgetTester tester) async {
    // SharedPreferences ni test kosam mock cheddam
    SharedPreferences.setMockInitialValues({});
    
    final expenseProvider = ExpenseProvider();
    await expenseProvider.loadExpenses();

    // App ni pump cheddam
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: expenseProvider,
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    // "No expenses yet" ane text kanipisthundo ledo check cheddam
    expect(find.text('No expenses yet.\nStart tracking now!'), findsOneWidget);
  });
}