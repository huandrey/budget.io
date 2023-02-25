import 'package:expenses/models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(this.transactions, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.3,
        child: transactions.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Nenhuma transacao cadastrada",
                      style: Theme.of(context).textTheme.headline6),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: SizedBox(
                        height: 200,
                        child: Image.asset('assets/images/waiting.png',
                            fit: BoxFit.cover)),
                  )
                ],
              )
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final tr = transactions[index];

                  return Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                          tr.title.length > 11
                              ? '${tr.title.substring(0, 10)}...'
                              : tr.title,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'OpenSans',
                              fontSize: 16)),
                      subtitle: Text(DateFormat('dd MMM y').format(tr.date)),
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'R\$ ${tr.value.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.headline6,
                            // style: TextStyle(
                            //   fontWeight: FontWeight.bold,
                            //   fontSize: 14,
                            //   color: Colors.white,
                            // ),
                          )
                        ],
                      ),
                      // decoration: BoxDecoration(
                      //     border: Border.all(
                      //   color: Colors.black,
                      //   width: 2,
                      // )),
                      // margin: const EdgeInsets.symmetric(
                      //   horizontal: 15,
                      //   vertical: 10,
                      // ),
                      // padding: const EdgeInsets.all(10),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              color: Theme.of(context).errorColor,
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.delete_outline_outlined),
                              color: Theme.of(context).errorColor,
                              onPressed: () => onRemove(tr.id),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}
