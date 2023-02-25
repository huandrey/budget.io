import 'dart:math';

import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/Transaction.dart';
import 'package:flutter/material.dart';

class TransactionController extends StatefulWidget {
  const TransactionController({super.key});

  @override
  State<TransactionController> createState() => _TransactionControllerState();
}

class _TransactionControllerState extends State<TransactionController> {
  final _transactions = [
    Transaction(
        id: 't1', title: 'Novo tenis', value: 629.90, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Nova blusa', value: 329.90, date: DateTime.now()),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // TransactionForm(_addTransaction),
        // TransactionList(_transactions),
      ],
    );
  }
}
