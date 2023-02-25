import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class Chart extends StatefulWidget {
  final List<Transaction> lastTransactions;

  Chart(this.lastTransactions, {super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollDown());
  }

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double sum = 0.0;

      for (var i = 0; i < widget.lastTransactions.length; i++) {
        bool sameDay = widget.lastTransactions[i].date.day == weekDay.day;
        bool sameMonth = widget.lastTransactions[i].date.month == weekDay.month;
        bool sameYear = widget.lastTransactions[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          sum += widget.lastTransactions[i].value;
        }
      }

      final days = [
        {'0': 'Hoje'},
        {'Sun': 'Domingo'},
        {'Sat': 'Sábado'},
        {'Fri': 'Sexta'},
        {'Thu': 'Quinta'},
        {'Wed': 'Quarta'},
        {'Tue': 'Terça'},
        {'Mon': 'Segunda'},
      ];

      String sigla =
          index == 0 ? '0' : DateFormat.E().format(weekDay).toString();
      var day = '';

      switch (sigla) {
        case '0':
          day = 'Hoje';
          break;
        case 'Sun':
          day = 'Domingo';
          break;
        case 'Sat':
          day = 'Sábado';
          break;
        case 'Fri':
          day = 'Sexta';
          break;
        case 'Thu':
          day = 'Quinta';
          break;
        case 'Wed':
          day = 'Quarta';
          break;
        case 'Tue':
          day = 'Terça';
          break;
        case 'Mon':
          day = 'Segunda';
          break;
      }

      return {
        'day': day,
        'value': sum,
      };
    }).reversed.toList();
  }

  // x - 50
  double get _weekTotalValue {
    return widget.lastTransactions.fold(0.0, (sum, tr) {
      return sum + tr.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: groupedTransactions
                    .map((tr) => ChartBar(
                        label: tr['day'].toString(),
                        value: tr['value'] as double,
                        percentage: _weekTotalValue == 0.0
                            ? 0
                            : (tr['value'] as double) / _weekTotalValue))
                    .toList(),
              ),
            ),
          ),
        ));
  }
}
