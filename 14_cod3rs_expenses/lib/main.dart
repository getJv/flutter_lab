import 'dart:io';

import 'package:cod3rs_expenses/components/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Garante que a aplicação não vá para landscape
    /* SystemChrome.setPreferredOrientations([
       DeviceOrientation.portraitUp,
     ]); */

    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              button: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          //Dica de como customizar estilos para todo o app
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    int nextId = this._transactions.length + 1;
    final newTransaction = Transaction(
      id: 't${nextId.toString()}',
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      this._transactions.add(newTransaction);
    });
    // Retiro o modal no topo da pilha.
    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(
          onSubmit: _addTransaction,
        );
      },
    );
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) {
        return tr.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    bool _isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text(
        'Despesas pessoais',
        // Importante para manter a proporção do texto conforme a configuraão do usuário.
        style: TextStyle(fontSize: 20 * mediaQuery.textScaleFactor),
      ),
      actions: <Widget>[
        if (_isLandscape)
          IconButton(
            icon: Icon(_showChart ? Icons.list : Icons.pie_chart),
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
          ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        )
      ],
    );

    final availiableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_showChart || !_isLandscape)
              Container(
                height: availiableHeight * (_isLandscape ? 0.7 : 0.3),
                child: Chart(
                  recentTransactions: _recentTransactions,
                ),
              ),
            if (!_showChart || !_isLandscape)
              Container(
                height: availiableHeight * (_isLandscape ? 1 : 0.3),
                child: TransactionList(
                  transactions: _transactions,
                  onRemove: _deleteTransaction,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _openTransactionFormModal(context),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
