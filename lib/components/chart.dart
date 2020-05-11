import 'package:cod3rs_expenses/components/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({this.recentTransactions});

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        // Pega a primeira letra da semana
        String firstLetterWeekDay = DateFormat.E().format(weekDay)[0];

        double totalSum = 0.0;

        for (int i = 0; i < recentTransactions.length; i++) {
          bool isSameDay = recentTransactions[i].date.weekday == weekDay.day;
          bool isSameMonth = recentTransactions[i].date.month == weekDay.month;
          bool isSameYear = recentTransactions[i].date.year == weekDay.year;

          if (isSameDay && isSameMonth && isSameYear) {
            totalSum += recentTransactions[i].value;
          }
        }

        return {
          'day': firstLetterWeekDay,
          'value': totalSum,
        };
      },
    ).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, item) {
      return sum + item['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'],
                value: tr['value'],
                percentage: _weekTotalValue == 0
                    ? 0
                    : (tr['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
